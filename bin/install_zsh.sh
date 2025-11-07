#!/bin/bash

# zsh and Oh My Zsh
sudo apt update --yes
sudo apt install --yes zsh
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /usr/bin/zsh

# symlinks for config files
ln -sf ~/dotfiles/system/.zshrc ~/.zshrc
ln -sf ~/dotfiles/system/.zprofile ~/.zprofile

# load zsh variables
source ~/.zprofile

# theme for Zsh
wget -P ${ZSH:-~/.oh-my-zsh}/themes https://raw.githubusercontent.com/ARtoriouSs/chaotic-beef-zsh-theme/master/chaotic-beef.zsh-theme

# zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# generate gh completion script
sudo mkdir -p /usr/local/share/zsh/site-functions
gh completion -s zsh | sudo tee /usr/local/share/zsh/site-functions/_gh >/dev/null
