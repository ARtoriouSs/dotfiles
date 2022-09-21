#!/bin/bash

sudo apt-get update --yes
sudo apt-get install --yes git

cd ~
git clone https://github.com/ARtoriouSs/dotfiles.git
./dotfiles/bin/prepare.sh
