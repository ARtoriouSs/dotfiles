#!/bin/bash

# zsh and Oh My Zsh
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  chsh -s /usr/bin/zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
upgrade_oh_my_zsh

# theme for Zsh
wget -P $ZSH/themes https://raw.githubusercontent.com/ARtoriouSs/chaotic-beef-zsh-theme/master/chaotic-beef.zsh-theme

# zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
