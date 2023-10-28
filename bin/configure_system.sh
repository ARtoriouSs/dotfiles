#!/bin/bash

gh config set git_protocol ssh

# fonts
cd ~/.local/share/fonts/
sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf

fc-cache -f -v # update fonts cache
cd -

echo "Fonts were installed, enable it in terminal preferences:"
echo "Edit -> Preferences -> Text -> Custom font"
echo "Search for Droid Sans Mono"
