#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  : # none
elif [[ "$OSTYPE" == "linux-android"* ]]; then
  : # none
fi

gh config set git_protocol ssh

# fonts
local url=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  cd /usr/local/share/fonts && sudo curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" $url
  fc-cache -f -v # update fonts cache
  echo "Fonts were installed, enable it in terminal preferences:"
  echo "Edit -> Preferences -> Text -> Custom font"
  echo "Search for Droid Sans Mono"
elif [[ "$OSTYPE" == "linux-android" ]]; then
  : # nope
fi
