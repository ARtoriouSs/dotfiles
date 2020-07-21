#!/bin/bash

# this script should install programs on a recently installed system
# and run all other scripts in this directory to prepare system to use
# do not run it if system isn't empty, in that case run needed scripts separately

if [ -z "$1" ]; then
  echo "Type 'y' to reset working tree to $(git rev-parse --short HEAD)"
  echo "Ensure that you running login shell before running this script"
  echo "Press 'y' to proceed, or type 'bash -l' and try again."
  read key
  if [ "$key" != "y" ]; then
    echo "Aborted"
    exit
  fi
fi

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
echo "Now you may need to perform some manual configuration:"
echo
echo "1) Make terminal run login shell by default:"
echo "Edit -> Prefeneces -> Profiles -> Command -> Check 'run command as a login shell' option,"
echo "optionally add 'zsh -l' as a login command"
echo "2) Make terminal run maximized by default:"
echo "Edit -> Prefeneces -> Profiles -> Text -> Set default terminal size as 240 columns and 100 rows"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "3) Enable fonts in terminal:"
  echo "Edit -> Preferences -> Text -> Custom font, search for Droid Sans Mono"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "3) Enable fonts in terminal:"
  echo "Restart terminal (not just relogin), Edit -> Prefeneces -> Profiles -> Text -> Font, search for Droid Sans Mono"

  echo "4) Use option/alt key as metakey in terminal to use in mappings:"
  echo "iTerm2 -> Preferences -> Profiles -> Keys, check Left ⌥ Key as Esc+"
fi

echo "Also you can manually run add_ssh.sh and enable_snap.sh when needed."

exec zsh -l # relogin in the end
