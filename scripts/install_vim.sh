#!/bin/bash

# install vim
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    add-apt-repository ppa:jonathonf/vim
    apt-get update
    apt-get install vim
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install vim
fi

# symlink for config
ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc

# setup color scheme
mkdir $HOME/.vim/colors
cp ../vim/monokai.vim $HOME/.vim/colors

# install Plug and plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PluginInstall +qall
