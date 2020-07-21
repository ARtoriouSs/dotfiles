#!/bin/bash

# this script should prepate a recently installed system to use,
# it will run all other scripts in this directory

#if [ test $(shopt -q login_shell) ]; then
  #echo "You are currently running a non-login shell, type 'bash -l' and run script again"
  #echo "Aborted"
  #exit
#fi

cd ~/dotfiles/scripts # if runned from outside

cp ../shell/temp_settings.sample.sh ../shell/temp_settings.sh

./create_symlinks.sh
./install_cli.sh
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
