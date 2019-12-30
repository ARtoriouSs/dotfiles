#!/bin/bash

# create symlinks to dotfiles
ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/.zprofile ~/.zprofile
ln -sf ~/dotfiles/shell/.bashrc ~/.bashrc
ln -sf ~/dotfiles/shell/.profile ~/.profile
ln -sf ~/dotfiles/.gemrc ~/.gemrc
ln -sf ~/dotfiles/.pryrc ~/.pryrc
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

if [ ! -d "$HOME/.bundle" ]; then
  mkdir ~/.bundle
fi
ln -sf ~/dotfiles/bundler_config ~/.bundle/bundler_config
