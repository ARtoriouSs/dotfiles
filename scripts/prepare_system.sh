#!/bin/bash

# this script should install programs on a recently installed system
# and run all other scripts in this directory to prepare system to use
# do not run it if system isn't empty, in that case run needed scripts separately
# must be running with sudo

cp ~dotfiles/shell/temp_settings.sample.sh ~dotfiles/shell/temp_settings.sh

./create_symlinks.sh
./install_software.sh
if [ ! -f /.dockerenv ]; then # if not in docker
  ./install_gui.sh
fi
./configure_system.sh
./create_dir_tree.sh
./install_vim.sh
./install_zsh.sh

exec zsh
