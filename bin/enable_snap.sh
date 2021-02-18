#!/bin/bash

# in Linux Mint 20 snap is disabled by default, but if it needed it can be reenabled and installed

sudo rm /etc/apt/preferences.d/nosnap.pref

sudo apt update --yes
sudo apt install --yes snapd
