#!/bin/bash

# in Linux Mint 20 snap is disabled by default, but if it needed it can be reenabled and installed

sudo rm /etc/apt/preferences.d/nosnap.pref

sudo apt-get update --yes
sudo apt-get install --yes snapd
