#!/bin/bash

# install vim
apt-get update
apt-get install vim

# setup color scheme
mkdir $HOME/.vim/colors
cp ../vim/monokai.vim $HOME/.vim/colors

# install plugins
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
