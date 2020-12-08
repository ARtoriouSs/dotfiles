#!/bin/bash

# zsh and Oh My Zsh
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  sudo apt update --yes
  sudo apt install --yes zsh
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
elif [[ "$OSTYPE" == "linux-android" ]]; then
  # https://wiki.termux.com/wiki/ZSH
fi
sudo chsh -s /usr/bin/zsh

# symlinks for config files
ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/.zprofile ~/.zprofile

# load zsh variables
source ~/.zprofile

# theme for Zsh
wget -P ${ZSH:-~/.oh-my-zsh}/themes https://raw.githubusercontent.com/ARtoriouSs/chaotic-beef-zsh-theme/master/chaotic-beef.zsh-theme

# zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
