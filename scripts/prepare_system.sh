#!/bin/bash

# this script should install programs on a recently installed system
# and run all other scripts in this directory to prepare system to use
# do not run it if system isn't empty, in that case run needed scripts separately
# must be running with sudo

cd ~/dotfiles/scripts # if runned from outside

cp ../shell/temp_settings.sample.sh ../shell/temp_settings.sh

./create_symlinks.sh
./install_software.sh
if [ ! -f /.dockerenv ]; then # if not in docker
  ./install_gui.sh
fi
./configure_system.sh
./install_rbenv.sh
./install_zsh.sh && source ~/.zprofile
./install_vim.sh
./create_dir_tree.sh

cd -

# reminder about manual/GUI configurations
echo "Now you need to perform some manual configuration:"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "1) Enable fonts in terminal:"
  echo "Edit -> Preferences -> Text -> Custom font, search for Droid Sans Mono"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "1) Enable fonts in terminal:"
  echo "Restart terminal (not just relogin), Prefeneces -> Profiles -> Text -> Font, search for Droid Sans Mono"

  echo "2) Use option/alt key as metakey in terminal to use in mappings:"
  echo "iTerm2 -> Preferences -> Profiles -> Keys, check Left ⌥ Key as Esc+"
fi

exec zsh -l # relogin in the end
