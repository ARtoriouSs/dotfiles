# Dotfiles

This is the repo with my system configuration.

[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash.png?v=103)](/shell)

## How does it work?

Implied that all dotfiles stored in `$HOME/dotfiles` directory and have symlinks to their original locations.
So it's possible manage and commit them from one place. All the configuration and scripts here are compatible with both
MacOS and Debian-like Linux systems.

Everything here is configured for my convenience, especially for Ruby/JavaScript development.

I tried to make everything easy to understand, so there are a lot of comments if someone wants to use or adopt it.

#### Here is:

- [Script for installing everything](scripts/prepare.sh) from here on empty Linux system
- Configured [.bashrc](shell/.bashrc) and [.profile](shell/.profile)
- [Script for installing zsh](scripts/install_zsh.sh) with configured [.zshrc](shell/.zshrc), [.zprofile](shell/.zprofile) and extensions
- [Aliases](shell/aliases.sh) and some convenient shell [functions](shell/functions.sh)
- [Script for installing nvim](scripts/install_vim.sh) with configured [.vimrc](vim/.vimrc)
- Git settings: [gitconfig](git/.gitconfig), [global .gitignore](git/.gitignore.global), [template directory with hooks for ctags](git/git_template)
- [.pryrc](.pryrc) configured for convenient ruby debugging
- [bundler config](bundler_config)
- [.gemrc](.gemrc) to not to download documentation

#### Will be installed with installation scripts:

- Basic software (curl, wget, homebrew (for MacOS), git, etc.)
- Tmux, Neovim, Ctags
- Zsh with Oh-My-Zsh
- Docker and docker-compose
- Ruby, Rbenv
- NodeJS and npm
- PostgreSQL, Redis
- Slack, Skype, Telegram, Google Chrome, Discord

To install **everything** run:

```bash
cd ~
git clone https://github.com/ARtoriouSs/dotfiles.git
./dotfiles/scripts/prepare.sh
```

Every script will work correctly when run separately, but keep in mind that you should use symlinking to use it as is,
othervise you should copy dotfiles to their original location. Also check READMEs in other directories for more info.

## Testing

If you unsure running something you can load test environment with Docker:

```bash
./test/test.sh
```

Here are the [healthcheck script](healthcheck.sh) and the [test script](test.sh) for testing this repo in docker.
It runs an empty linux sandbox with Linux Mint 20 as a **"test"** user with **"test"** password.

# Scripts

Installation scripts must be executed with sudo.

## Explanations

- [prepare.sh](prepare.sh) - prepares recently installed system. It will also execute all other scripts here. Don't run it if you don't need everithing.
- [create_symlinks.sh](create_symlinks.sh) - Adds symlinks for all dotfiles in this repo so they can store in one place.
- [install_cli.sh](install_cli.sh) - Installs cli programmes.
- [configure_system.sh](configure_system.sh) - Sets up some system settings.
- [add_ssh.sh](add_ssh.sh) - Generates ssh key and adds it to ssh-agent. Takes email as first argument.
- [enable_snap.sh](enable_snap.sh) - Reenables snap for new Linux Mint if needed.

Other scripts install appropriate software and described in other READMEs
