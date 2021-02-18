#!/bin/bash

gh config set git_protocol ssh

# fonts
cd /usr/local/share/fonts && sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
fc-cache -f -v # update fonts cache

echo "Fonts were installed, enable it in terminal preferences:"
echo "Edit -> Preferences -> Text -> Custom font"
echo "Search for Droid Sans Mono"
