#!/bin/bash

# this script should install programs on a recently installed system
# and run all other scripts in this directory to prepare system to use
# do not run it if system isn't empty, in that case run needed scripts separately
# must be running with sudo

relogin() {
    exec bash
}

./install_software.sh && relogin

./create_symlinks.sh && relogin

./configure_system.sh && relogin

./create_dir_tree.sh
./install_vim.sh
./install_vscode.sh
./install_zsh.sh

exec zsh
