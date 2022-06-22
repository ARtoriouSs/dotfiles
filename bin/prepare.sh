#!/bin/bash

# this script should prepate a recently installed system to use,
# it will run all other scripts in this directory

cd ~/dotfiles/bin # if runned from outside

cp ../system/temp_settings.sample.sh ../system/temp_settings.sh

./create_symlinks.sh
./install_cli.sh
./install_gui.sh
./configure_system.sh
./install_rbenv.sh
./install_zsh.sh && source ~/.zprofile
./install_vim.sh
./create_dir_tree.sh

git remote set-url origin git@github.com:$GITHUB_USERNAME/dotfiles.git # change remote link for this repo to use SSH

cd -

# reminder about manual/GUI configurations
echo
echo "Now you may need to perform some manual configuration:"
echo
echo "1) Reboot"
echo "2) Make terminal run login shell by default:"
echo "Edit -> Prefeneces -> Profiles -> Command -> Check 'run command as a login shell' option,"
echo "optionally add 'zsh -l' as a login command"
echo "3) Make terminal run maximized by default:"
echo "Edit -> Prefeneces -> Profiles -> Text -> Set default terminal size as 340 columns and 100 rows"
echo "4) Enable fonts in terminal:"
echo "Edit -> Preferences -> Profiles -> Text -> Custom font, search for Droid Sans Mono"
echo
echo "Also you can manually run add_ssh.sh and enable_snap.sh when needed."
echo

exec zsh -l # relogin in the end
