#!/bin/bash

# this script should install basic programs on a recently installed system
# and run all other scripts in this directory to prepare system to use.
# It will install just basic environment without something specific.

# base software
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    apt-get update
    apt-get upgrade
    apt-get install software-properties-common apt-transport-https wget curl
elif [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew cask install iterm2
    brew install curl wget
fi

# more software
if [[ "$OSTYPE" == "linux-gnu" ]]; then # TODO:verify
    # docker
    apt-get install apt-transport-https ca-certificates
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io
    # docker-compose
    sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    # rbenv
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src # Can fail, it's ok
    ~/.rbenv/bin/rbenv init
    # ruby-build for rbenv
    mkdir -p "$(rbenv root)"/plugins 
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # docker
    echo "You need to install Docker manualy on MacOS: https://runnable.com/docker/install-docker-on-macos"
    # rbenv
    brew install rbenv
    rbenv init
fi

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash # verify rbenv

./create_symlinks.sh
./create_dir_tree.sh
./install_zsh.sh
./install_vim.sh
./install_vscode.sh
