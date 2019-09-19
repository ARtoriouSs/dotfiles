#!/bin/bash

# install vim
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    apt-get update
    apt-get install vim
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install vim
fi

# setup color scheme
mkdir $HOME/.vim/colors
cp ../vim/monokai.vim $HOME/.vim/colors

# install plugins
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# symlink for config
ln -sf $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
