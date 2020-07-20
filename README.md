# Dotfiles

This is repo with my system configuration.

## How does it work?

Implied that all dotfiles stored in `$HOME/dotfiles` directory and have symlinks to their original locations.
So it's possible manage and commit them from one place. All the configuration and scripts here are compatible with both
MacOS and Debian-like Linux systems.

Everything here is configured for my convenience, especially for Ruby/JavaScript development.

I tried to make everything easy to understand, so there are a lot of comments if someone wants to use or adopt it.

#### Here is:

- [Script for installing everything](scripts/prepare_system.sh) from here on empty Linux system
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
- Slack, Skype, Telegram, Google Chrome

To install **everything** run:

```bash
cd ~
git clone https://github.com/ARtoriouSs/dotfiles.git
./dotfiles/scripts/prepare_system.sh
```

Every script will work correctly when run separately, but keep in mind that you should use symlinking to use it as is,
othervise you should copy dotfiles to their original location. Also check READMEs in other directories for more info.

## Testing

If you unsure running something you can load test environment with Docker:

```bash
./test/test.sh
```

Check out [README in tests](test/README.md) for details.
