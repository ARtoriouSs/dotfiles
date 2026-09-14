#!/bin/bash

# create symlinks to dotfiles
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/development/.gemrc ~/.gemrc
ln -sf ~/dotfiles/development/.pryrc ~/.pryrc
ln -sf ~/dotfiles/system/.agignore ~/.agignore

[ ! -d "$HOME/.bundle" ] && mkdir ~/.bundle
ln -sf ~/dotfiles/development/bundler_config ~/.bundle/bundler_config
