#!/bin/bash


# create symlinks to dotfiles
mkdir ~/.ctags.d
ln -sf ~/dotfiles/system/default.ctags ~/.ctags.d/default.ctags

ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

if [ ! -d "$HOME/.bundle" ]; then
  mkdir ~/.bundle
fi
ln -sf ~/dotfiles/development/bundler_config ~/.bundle/bundler_config
ln -sf ~/dotfiles/development/.gemrc ~/.gemrc
ln -sf ~/dotfiles/development/.pryrc ~/.pryrc
