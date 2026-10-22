# frogswamp (home server) management tools. Sourced by system/initializer.sh,
# and by ~/.bashrc through the block bin/bootstrap_frogswamp.sh adds there

# Nix's profile script skips itself when __ETC_PROFILE_NIX_SOURCED is inherited from a
# parent process even though PATH was rebuilt without Nix, so clear the flag first.
# Linux Mint preloads libgtk3-nocsd session-wide; Nix binaries can't load it and warn
# on every run, so drop it in terminals (only GTK apps started from a shell are affected)
unset LD_PRELOAD
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
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
# DNS is left alone so the work VPN's DNS keeps working; ts-down leaves no service running
ts-up() { sudo systemctl start tailscaled && sudo tailscale up --accept-routes --accept-dns=false; }
ts-down() { sudo tailscale down; sudo systemctl stop tailscaled; }
