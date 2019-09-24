#!/bin/bash

# this script should install programs on a recently installed system
# and run all other scripts in this directory to prepare system to use
# do not run it if system isn't empty, in that case run needed scripts separately
# must be running with sudo

./install_software.sh
./configure_system.sh
./create_symlinks.sh
./create_dir_tree.sh
./install_zsh.sh
./install_vim.sh
./install_vscode.sh

# relogin
exec zsh
