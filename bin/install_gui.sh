#!/bin/bash

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install --yes ./google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb
# telegram
wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/
sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop
# skype
wget https://go.skype.com/skypeforlinux-64.deb
sudo apt install --yes ./skypeforlinux-64.deb
rm -f skypeforlinux-64.deb
# slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
sudo apt install --yes ./slack-desktop-4.0.2-amd64.deb
rm -f slack-desktop-4.0.2-amd64.deb
# discord
wget -O ./discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install --yes ./discord.deb
rm -f ./discord.deb
# insomnia
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" \
  | sudo tee -a /etc/apt/sources.list.d/insomnia.list
sudo apt update
sudo apt install --yes insomnia
