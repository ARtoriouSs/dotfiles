#!/bin/bash

# create symlinks to dotfiles
ln -sf $HOME/dotfiles/shell/.zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/shell/.zprofile $HOME/.zprofile
ln -sf $HOME/dotfiles/shell/.bashrc $HOME/.bashrc
ln -sf $HOME/dotfiles/shell/.profile $HOME/.profile
ln -sf $HOME/dotfiles/.gemrc $HOME/.gemrc
ln -sf $HOME/dotfiles/.pryrc $HOME/.pryrc
ln -sf $HOME/dotfiles/.gitconfig $HOME/.gitconfig
ln -sf $HOME/dotfiles/.gitignore_global $HOME/.gitignore_global

if [ ! -d "$HOME/.bundle" ]; then
  mkdir $HOME/.bundle
fi
ln -sf $HOME/dotfiles/bundler_config $HOME/.bundle/bundler_config
