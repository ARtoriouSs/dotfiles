#!/bin/bash

# from Linux Mint 20 snap is disabled by default, but it can be reenabled and installed if needed

sudo rm /etc/apt/preferences.d/nosnap.pref &> /dev/null

sudo apt update --yes
sudo apt install --yes snapd
