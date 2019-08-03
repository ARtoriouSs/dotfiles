#!/bin/bash

# this script should install basic programs on a recently installed system
# and run all other scripts in this directory

apt update
apt install software-properties-common apt-transport-https wget

# TODO: more

./create_dir_tree.sh
./install_zsh.sh
./create_symlinks.sh
./install_vim.sh
./install_sublime.sh
./install_vscode.sh
