#!/bin/bash

# install nvim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update --yes
sudo apt install --yes neovim
sudo apt install --yes python3-neovim

# support tools
sudo gem install neovim
sudo gem install solargraph # should be installed per project's ruby version
npm install -g neovim
python2 -m pip install --user --upgrade pynvim
python3 -m pip install --user --upgrade pynvim
npm install -g tree-sitter-cli # tree-sitter executable

# symlink for configs
mkdir -p ~/.config/nvim/lua
ln -sf ~/dotfiles/vim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/vim/lua/ ~/.config/nvim/lua/
mkdir -p ~/.config/solargraph
ln -sf ~/dotfiles/development/.solargraph.yml ~/.config/solargraph/config.yml

# install Lazy and plugins
nvim -u ~/dotfiles/vim/lua/_plugins.lua +Lazy +qall
