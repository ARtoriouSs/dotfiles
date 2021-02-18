#!/bin/bash

# create symlinks to dotfiles
ln -sf ~/dotfiles/shell/.bashrc ~/.bashrc
ln -sf ~/dotfiles/shell/.profile ~/.profile
ln -sf ~/dotfiles/.gemrc ~/.gemrc
ln -sf ~/dotfiles/.pryrc ~/.pryrc
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
mkdir ~/.ctags.d
ln -sf ~/dotfiles/default.ctags ~/.ctags.d/default.ctags

if [ ! -d "$HOME/.bundle" ]; then
  mkdir ~/.bundle
fi
ln -sf ~/dotfiles/bundler_config ~/.bundle/bundler_config
