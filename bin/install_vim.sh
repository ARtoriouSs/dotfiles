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

# symlink for configs
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/vim/.vimrc ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sf ~/dotfiles/development/.solargraph.yml ~/.config/solargraph/config.yml

# install Plug and plugins
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -u ~/dotfiles/vim/plugins.vim +PlugInstall +qall
