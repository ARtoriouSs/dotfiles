#!/bin/bash
set -o pipefail # a pipeline fails when any command in it fails, not only the last one

# create symlinks to dotfiles
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/development/.gemrc ~/.gemrc
ln -sf ~/dotfiles/development/.pryrc ~/.pryrc
ln -sf ~/dotfiles/system/.agignore ~/.agignore
