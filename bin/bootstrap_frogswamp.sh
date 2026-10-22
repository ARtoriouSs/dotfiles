#!/usr/bin/env bash
# Prepares this PC (Linux Mint / Ubuntu / Debian) to manage the frogswamp home server.
# Usage: bin/bootstrap_frogswamp.sh [path to the frogswamp repo, default ~/frogswamp]
# The frogswamp repo's scripts/bootstrap-local.sh downloads and runs this file.
# Safe to re-run: every step is skipped when already done.
set -euo pipefail

repo_root="$(cd "${1:-$HOME/frogswamp}" && pwd)"
dotfiles="$HOME/dotfiles"
helpers="$dotfiles/frogswamp/helpers.sh"
ssh_key="$HOME/.ssh/frogswamp_ed25519"
age_key="$HOME/.config/sops/age/keys.txt"
nix_conf="$HOME/.config/nix/nix.conf"
direnvrc="$HOME/.config/direnv/direnvrc"

say()  { printf '\n\033[1;32m==>\033[0m %s\n' "$*"; }
skip() { printf '    \033[2mok: %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*"; }

if [ "$(id -u)" -eq 0 ]; then
  echo "Run as your normal user, not root (sudo is requested when needed)." >&2
  exit 1
fi
if ! grep -qiE '^(ID|ID_LIKE)=.*(debian|ubuntu)' /etc/os-release; then
  echo "Only Debian/Ubuntu-based systems (e.g. Linux Mint) are supported." >&2
  exit 1
fi
if [ ! -f "$repo_root/flake.nix" ]; then
  echo "$repo_root doesn't look like the frogswamp repo (no flake.nix). Pass its path as the first argument." >&2
  exit 1
fi

say "1/7 Nix"
if command -v nix >/dev/null 2>&1 || [ -x /nix/var/nix/profiles/default/bin/nix ]; then
  skip "Nix is installed"
else
  installer="$(mktemp)"
  curl --proto '=https' --tlsv1.2 -sSfL https://nixos.org/nix/install -o "$installer"
  sh "$installer" --daemon --yes
  rm -f "$installer"
fi
if ! command -v nix >/dev/null 2>&1; then
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

say "2/7 Flakes"
if grep -qs '^experimental-features.*flakes' "$nix_conf"; then
  skip "flakes enabled in $nix_conf"
else
  mkdir -p "$(dirname "$nix_conf")"
  echo 'experimental-features = nix-command flakes' >>"$nix_conf"
  skip "enabled flakes in $nix_conf"
fi

say "3/7 direnv + nix-direnv, shell setup"
if nix profile list 2>/dev/null | grep -q 'nix-direnv'; then
  skip "direnv and nix-direnv installed"
else
  nix profile install nixpkgs#direnv nixpkgs#nix-direnv
fi
mkdir -p "$(dirname "$direnvrc")"
if grep -qs 'nix-direnv/direnvrc' "$direnvrc"; then
  skip "nix-direnv sourced in $direnvrc"
else
  # shellcheck disable=SC2016 # literal $HOME belongs in direnvrc
  echo 'source "$HOME/.nix-profile/share/nix-direnv/direnvrc"' >>"$direnvrc"
fi
direnv_toml="$HOME/.config/direnv/direnv.toml"
if grep -qs 'hide_env_diff' "$direnv_toml"; then
  skip "direnv hides env diffs"
elif grep -qs '^\[global\]' "$direnv_toml"; then
  warn "Add 'hide_env_diff = true' under [global] in $direnv_toml to shorten direnv output."
else
  printf '[global]\nhide_env_diff = true\n' >>"$direnv_toml"
  skip "set hide_env_diff in $direnv_toml"
fi
# zsh loads frogswamp/helpers.sh through system/initializer.sh. Older versions of this script
# appended the same setup to the rc files; remove that, and point bash at the helpers instead
for rc in "$HOME/.zshrc" "$HOME/.bashrc"; do
  [ -e "$rc" ] || continue
  target="$(readlink -f "$rc")" # edit the real file; sed -i would replace a symlink
  if grep -qs '# frogswamp-shell-begin' "$target"; then
    sed -i '/# frogswamp-shell-begin/,/# frogswamp-shell-end/d' "$target"
    skip "removed the old frogswamp block from $target"
  fi
done
if [ -e "$HOME/.bashrc" ]; then
  if grep -qs '# frogswamp-helpers' "$HOME/.bashrc"; then
    skip "bash loads $helpers"
  else
    printf '\n[ -f "%s" ] && . "%s" # frogswamp-helpers\n' "$helpers" "$helpers" >>"$HOME/.bashrc"
    skip "bash now loads $helpers"
  fi
fi
if ! grep -qs 'frogswamp/helpers.sh' "$dotfiles/system/initializer.sh"; then
  warn "$dotfiles/system/initializer.sh doesn't source frogswamp/helpers.sh: zsh won't have ts-up/ts-down or direnv."
  warn "Clone the dotfiles repo to $dotfiles (see its README)."
fi

say "4/7 Admin age key (decrypts repo secrets)"
if [ -s "$age_key" ]; then
  skip "age key exists at $age_key"
else
  mkdir -p "$(dirname "$age_key")"
  nix shell nixpkgs#age --command age-keygen -o "$age_key"
  chmod 600 "$age_key"
  warn "NEW age key created at $age_key"
  warn "STORE ITS CONTENT IN YOUR PASSWORD MANAGER NOW. Without it (and the server) all secrets are lost."
fi

say "5/7 Admin SSH key"
if [ -s "$ssh_key" ]; then
  skip "SSH key exists at $ssh_key"
else
  mkdir -p "$HOME/.ssh"
  ssh-keygen -q -t ed25519 -N "" -C "frogswamp-admin" -f "$ssh_key"
fi
mkdir -p "$repo_root/keys"
if cmp -s "$ssh_key.pub" "$repo_root/keys/admin.pub"; then
  skip "keys/admin.pub up to date"
else
  cp "$ssh_key.pub" "$repo_root/keys/admin.pub"
  skip "copied public key to keys/admin.pub"
fi
if grep -qs '# frogswamp-begin' "$HOME/.ssh/config"; then
  skip "frogswamp block present in $HOME/.ssh/config"
else
  cat >>"$HOME/.ssh/config" <<EOF

# frogswamp-begin
Host frogswamp 192.168.101.10 frogswamp.local frogswamp-installer.local
  IdentityFile $ssh_key
  IdentitiesOnly yes
# frogswamp-end
EOF
  chmod 600 "$HOME/.ssh/config"
  skip "added frogswamp block to ~/.ssh/config"
fi

say "6/7 Tailscale (off until ts-up)"
if command -v tailscale >/dev/null 2>&1; then
  skip "Tailscale is installed"
else
  # Mint has its own codename; the Ubuntu one picks the right repo
  # shellcheck disable=SC1091
  codename="$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")"
  distro=ubuntu
  grep -qiE '^(ID|ID_LIKE)=.*ubuntu' /etc/os-release || distro=debian
  curl -fsSL "https://pkgs.tailscale.com/stable/$distro/$codename.noarmor.gpg" |
    sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
  curl -fsSL "https://pkgs.tailscale.com/stable/$distro/$codename.tailscale-keyring.list" |
    sudo tee /etc/apt/sources.list.d/tailscale.list >/dev/null
  sudo apt-get update -qq
  sudo apt-get install -y -qq tailscale
fi
# the package starts it at boot; here it only runs between ts-up and ts-down
if systemctl is-enabled --quiet tailscaled 2>/dev/null || systemctl is-active --quiet tailscaled; then
  sudo systemctl disable --now tailscaled
  skip "tailscaled stopped and kept off at boot"
else
  skip "tailscaled is off"
fi

say "7/7 Done. Next steps:"
cat <<'EOF'
  1. Open a new terminal (loads Nix, direnv, ts-up/ts-down).
  2. cd into the frogswamp repo and run:  direnv allow
  3. Run:  just     (lists all commands)
  4. Away from home (e.g. phone hotspot): ts-up, then ssh root@192.168.101.10 or the
     Homepage links work as at home. ts-down when done. The first ts-up prints a login link:
     sign in with the same Tailscale account as the server.
EOF
