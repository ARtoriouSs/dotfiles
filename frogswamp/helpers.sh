# shellcheck shell=bash
# frogswamp (home server) management tools. Sourced by system/initializer.sh,
# and by ~/.bashrc through the block bin/bootstrap_frogswamp.sh adds there.
# Every part is skipped when its tool isn't installed, so it's safe on a PC without frogswamp

# Nix's profile script skips itself when __ETC_PROFILE_NIX_SOURCED is inherited from a
# parent process even though PATH was rebuilt without Nix, so clear the flag first.
# Linux Mint preloads libgtk3-nocsd session-wide; Nix binaries can't load it and warn
# on every run, so drop it in terminals (only GTK apps started from a shell are affected)
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  unset LD_PRELOAD
  unset __ETC_PROFILE_NIX_SOURCED
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# per-directory dev environments (the frogswamp repo's .envrc)
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook "${ZSH_VERSION:+zsh}${BASH_VERSION:+bash}")"
fi

# edit the server's secrets (just secrets) in nvim; EDITOR stays as set in system/environment.sh
export SOPS_EDITOR=nvim

# Tailscale only on demand (e.g. on a phone hotspot): reach the server and 192.168.101.x through it.
# accept-dns only adds the tailnet's *.ts.net names (the tailnet sets no DNS servers of its own),
# so lavish links and "frogswamp" resolve and the work VPN's DNS stays as it is.
# ts-down leaves no service running
if command -v tailscale >/dev/null 2>&1; then
  ts-up() { sudo systemctl start tailscaled && sudo tailscale up --accept-routes --accept-dns=true; }
  ts-down() { sudo tailscale down; sudo systemctl stop tailscaled; }
fi
