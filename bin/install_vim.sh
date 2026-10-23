#!/bin/bash
set -o pipefail # a pipeline fails when any command in it fails, not only the last one

# install nvim from the official release: the stable PPA is years behind and the unstable one is a nightly
nvim_archive=$(mktemp)
curl -fsSL https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz -o "$nvim_archive"
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf "$nvim_archive"
rm -f "$nvim_archive"
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
sudo apt install --yes python3-neovim # python provider (pynvim), pip can't install it globally on noble

# support tools
sudo gem install neovim
npm install -g neovim
npm install -g --allow-scripts=tree-sitter-cli tree-sitter-cli # tree-sitter executable, downloaded by its install script
sudo apt install --yes chafa bat # for previewing images

# symlink for configs
mkdir -p ~/.config/nvim/
ln -sf ~/dotfiles/vim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/vim/lua/ ~/.config/nvim/
ln -sf ~/dotfiles/vim/lazy-lock.json ~/.config/nvim/lazy-lock.json # plugin versions, Lazy writes updates through the link

# install Lazy and plugins at the versions from lazy-lock.json
nvim --headless -u ~/dotfiles/vim/lua/_plugins.lua "+Lazy! restore" +qall
