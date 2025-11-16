#!/bin/bash

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install --yes ./google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb
# telegram
wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C /opt/
sudo ln -s /opt/Telegram/Telegram /usr/local/bin/telegram-desktop
# slack
sudo apt install --yes slack
# discord
wget -O ./discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install --yes ./discord.deb
rm -f ./discord.deb
# insomnia
wget "https://updates.insomnia.rest/downloads/ubuntu/latest" -O insomnia.deb
sudo apt install ./insomnia.deb
rm -f ./insomnia.deb
# postman
wget -O ~/postman.tar.gz "https://dl.pstmn.io/download/latest/linux_64"
sudo tar xvf ~/postman.tar.gz -C /opt/
rm ~/postman.tar.gz
echo "[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;" >> ~/.local/share/applications/Postman.desktop # Make the app accessible from a launcher icon
