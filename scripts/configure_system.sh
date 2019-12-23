#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # none
elif [[ "$OSTYPE" == "darwin"* ]]; then
    touch ~/.hushlogin # do not display login message
    defaults write -g KeyRepeat -int 0 # increase cursor repeat speed when holding arrow key (minimum in settings 2)
    defaults write -g InitialKeyRepeat -int 10 # decreace delay before repeat starts (minimum in settings 15)
fi

# fonts
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
elif [[ "$OSTYPE" == "darwin"* ]]; then
  cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
fi
echo "Fonts were installed, restart terminal (not just relogin) and enable it in preferences:"
echo "iTerm: Prefeneces -> Profiles -> Text -> Font"
echo "Gnome terminal: " # TODO
