# Dotfiles

This is the repo with my system configuration.

[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash.png?v=103)](/system)

## How does it work?

All dotfiles live in `$HOME/dotfiles` and are linked to the places where programs look for them,
so they can be changed and committed from one place. The scripts are made for Linux Mint 22 (Ubuntu 24.04 based),
other Debian-like systems should mostly work too.

Everything here is set up for my convenience, especially for Ruby/JavaScript development and work with AI agents.
There are a lot of comments, so it should be easy to read and take parts of it.

## Structure

| Directory                      | What is inside                                                                  |
|--------------------------------|---------------------------------------------------------------------------------|
| [bin](bin)                     | Install and setup scripts, healthcheck and the Docker test sandbox              |
| [system](system)               | Zsh config, environment variables, general aliases and the autostart entries    |
| [development](development)     | Ruby, Docker and Postgres helpers, Ruby tool configs and Claude Code settings    |
| [git](git)                     | Git config, global gitignore and git helpers                                    |
| [tmux](tmux)                   | Tmux config, helpers for project sessions and the workmux config                |
| [vim](vim)                     | Neovim config in Lua with plugins managed by lazy.nvim                          |
| [frogswamp](frogswamp)         | Shell tools to manage the [frogswamp](https://github.com/ARtoriouSs/frogswamp) home server |

Every directory has a short README with details.

Shell config is loaded in this order: `~/.zprofile` loads [environment.sh](system/environment.sh),
then zsh loads `~/.zshrc`, which starts Oh My Zsh and sources [initializer.sh](system/initializer.sh).
The initializer loads the helpers of every directory and, last, the private `system/temp_settings.sh`.

## Installation

```bash
cd ~
git clone https://github.com/ARtoriouSs/dotfiles.git
./dotfiles/bin/prepare.sh
```

`prepare.sh` runs all the install scripts in [bin](bin), at the end it prints the steps that have to be done by hand.
Every script also works on its own, see [bin/README.md](bin/README.md).

Private settings (current project, email, proxy) go to `system/temp_settings.sh`. It's created from
[temp_settings.sample.sh](system/temp_settings.sample.sh) and is ignored by git.

## Checking the setup

```bash
./bin/healthcheck.sh
```

It shows installed programs, dotfile links and the shell state, and exits with 1 when something is missing.

## Checks

- A pre-commit hook in [.githooks](.githooks) runs [gitleaks](https://github.com/gitleaks/gitleaks) and blocks commits
  with secrets. `prepare.sh` turns it on with `git config core.hooksPath .githooks`, false positives go to `.gitleaksignore`
- GitHub Actions ([checks.yml](.github/workflows/checks.yml)) run shellcheck (errors only) on the bash scripts
  and gitleaks on the whole history. Zsh-only helpers are skipped, shellcheck can't parse zsh

## Testing

If you are unsure about running something, try it in Docker first:

```bash
./bin/test.sh # add --rm to remove the container after exit
```

It starts an empty Linux Mint 22.2 sandbox as a **"test"** user with **"test"** password.
GUI apps started inside open as windows on the host desktop, run `xeyes` to check it.
Use `--no-sandbox` flag for electron/chromium based apps, e.g. `google-chrome --no-sandbox`.
