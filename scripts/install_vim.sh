#!/bin/bash

# install nvim
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  sudo apt-get update --yes
  sudo apt-get install --yes neovim
  sudo apt-get install python-neovim
  sudo apt-get install python3-neovim
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install neovim
fi

# support tools
gem install neovim
rbenv rehash
npm install -g neovim
python -m pip install --user --upgrade pynvim
python3 -m pip install --user --upgrade pynvim

# symlink for config
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/vim/.vimrc ~/.config/nvim/init.vim

# install Plug and plugins
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -u ~/dotfiles/vim/plugins.vim +PlugInstall +qall
