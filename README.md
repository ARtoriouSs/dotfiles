# Dotfiles

This is the repo with my system configuration.

[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash.png?v=103)](/system)

## How does it work?

Implied that all dotfiles stored in `$HOME/dotfiles` directory and have symlinks to their original locations.
So it's possible manage and commit them from one place. All the configuration and scripts here are compatible with
Debian-like Linux systems.

Everything here is configured for my convenience, especially for Ruby/JavaScript development.

I tried to make everything easy to understand, so there are a lot of comments if someone wants to use or adopt it.

#### Here is:

- [Script for installing everything](bin/prepare.sh) from here on empty Linux system
- [Script for installing zsh](bin/install_zsh.sh) with configured [.zshrc](system/.zshrc), [.zprofile](system/.zprofile) and extensions
- [Aliases and some convenient shell functions](system/helpers.sh)
- [Script for installing nvim](bin/install_vim.sh) with configured [.vimrc](vim/.vimrc)
- Git settings: [gitconfig](git/.gitconfig), [global .gitignore](git/.gitignore.global), [template directory with hooks for ctags](git/git_template)
- [.pryrc](development/.pryrc), [.gemrc](development/.gemrc) and [bundler config](development/bundler_config) for convenience in Ruby development
- And some other helpful things :)

#### Will be installed with installation scripts:

- Basic software (curl, wget, git, etc.)
- Tmux, Neovim, Ctags
- Zsh with Oh-My-Zsh
- Docker and docker-compose
- Ruby, Rbenv
- NodeJS and npm
- PostgreSQL, Redis
- Slack, Telegram, Google Chrome, Discord

To install **everything** run:

```bash
cd ~
git clone https://github.com/ARtoriouSs/dotfiles.git
./dotfiles/bin/prepare.sh
```

Every script will also work correctly when run separately:

- [prepare.sh](bin/prepare.sh) - prepares recently installed system. It will also execute all other scripts here. Don't run it if you don't need everithing.
- [configure_system.sh](bin/configure_system.sh) - Sets up some system settings.
- [create_dir_tree.sh](bin/create_dir_tree.sh) - Just created directories under home
- [create_symlinks.sh](bin/create_symlinks.sh) - Adds symlinks for all dotfiles in this repo so they can store in one place.
- [enable_snap.sh](bin/enable_snap.sh) - Linux Mint 20 disabled snap by default, so this script enables it if needed.
- [install_cli.sh](bin/install_cli.sh) - Installs CLI programmes.
- [install_gui.sh](bin/install_gui.sh) - Installs GUI programmes.
- [install_rbenv.sh](bin/install_rbenv.sh) - Installs rbenv and ruby-build.
- [install_vim.sh](bin/install_vim.sh) - Installs neovim with plugins and related things.
- [install_zsh.sh](bin/install_zsh.sh) - Installs and enables zsh.
- [add_ssh.sh](bin/add_ssh.sh) - Generates ssh key and adds it to ssh-agent. Takes email as first argument.

## Testing

If you unsure running something you can load test environment with Docker:

```bash
./bin/test.sh
```

It runs an empty linux sandbox with Linux Mint 20 as a **"test"** user with **"test"** password.
There is also the [healthcheck script](bin/healthcheck.sh).
