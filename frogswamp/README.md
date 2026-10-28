# frogswamp

Shell tools to manage the [frogswamp](https://github.com/ARtoriouSs/frogswamp) home server.
The PC is prepared by [bin/bootstrap_frogswamp.sh](../bin/bootstrap_frogswamp.sh), which downloads and runs
[scripts/bootstrap-local.sh](https://github.com/ARtoriouSs/frogswamp/blob/master/scripts/bootstrap-local.sh)
from the frogswamp repo: Nix, direnv, the admin age and SSH keys and Tailscale.

[helpers.sh](helpers.sh) is sourced by zsh (through `system/initializer.sh`) and by `~/.bashrc`. It:

- loads Nix and the direnv hook, so the frogswamp repo gets its dev environment from `.envrc`
- sets `SOPS_EDITOR=nvim` for editing the server secrets
- adds `ts-up` and `ts-down` to start Tailscale only when needed, e.g. on a phone hotspot

Each part is skipped when its tool (Nix, direnv, Tailscale) isn't installed, so it's safe on a PC without frogswamp.

`cdf` goes to `~/frogswamp`.
