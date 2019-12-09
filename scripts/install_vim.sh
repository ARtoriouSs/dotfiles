#!/bin/bash

# install vim
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install neovim
fi

# symlink for config
ln -sf ~/dotfiles/vim/.vimrc ~/.config/nvim/init.vim

# setup color scheme
mkdir $HOME/.config/nvim/colors
cp ../vim/monokai.vim $HOME/.config/nvim/colors/

# install Plug and plugins
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
