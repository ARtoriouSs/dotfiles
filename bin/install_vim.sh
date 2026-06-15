#!/bin/bash

# install nvim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update --yes
sudo apt install --yes neovim
sudo apt install --yes python3-neovim

# support tools
sudo gem install neovim
npm install -g neovim
python2 -m pip install --user --upgrade pynvim
python3 -m pip install --user --upgrade pynvim
npm install -g tree-sitter-cli # tree-sitter executable
sudo apt isntall --yes chafa bat # for previewing images

# symlink for configs
mkdir -p ~/.config/nvim/
ln -sf ~/dotfiles/vim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/vim/lua/ ~/.config/nvim/

# install Lazy and plugins
nvim -u ~/dotfiles/vim/lua/_plugins.lua +Lazy +qall
