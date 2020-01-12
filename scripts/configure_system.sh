#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # none
elif [[ "$OSTYPE" == "darwin"* ]]; then
  touch ~/.hushlogin # do not display login message
  defaults write -g KeyRepeat -int 0 # increase cursor repeat speed when holding arrow key (minimum in settings 2)
  defaults write -g InitialKeyRepeat -int 10 # decreace delay before repeat starts (minimum in settings 15)
fi

# fonts
local url=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  cd /usr/local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" $url
  fc-cache -f -v # update fonts cache
  echo "Fonts were installed, enable it in terminal preferences:"
  echo "Edit -> Preferences -> Text -> Custom font"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" $url
  echo "Fonts were installed, restart terminal (not just relogin) and enable it in preferences:"
  echo "Prefeneces -> Profiles -> Text -> Font"
fi
echo "Search for Droid Sans Mono"
