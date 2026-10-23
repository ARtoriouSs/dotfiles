# frogswamp

Shell tools to manage the [frogswamp](https://github.com/ARtoriouSs/frogswamp) home server.
The PC is prepared by [bin/bootstrap_frogswamp.sh](../bin/bootstrap_frogswamp.sh): Nix, direnv, the admin age and SSH keys
and Tailscale.

[helpers.sh](helpers.sh) is sourced by zsh (through `system/initializer.sh`) and by `~/.bashrc`. It:

- loads Nix and the direnv hook, so the frogswamp repo gets its dev environment from `.envrc`
- sets `SOPS_EDITOR=nvim` for editing the server secrets
- adds `ts-up` and `ts-down` to start Tailscale only when needed, e.g. on a phone hotspot

`cdf` goes to `~/frogswamp`.
