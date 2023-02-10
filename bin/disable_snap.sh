#!/bin/bash

# from Linux Mint 20 snap is disabled by default, but it can be reenabled and installed if needed (./enable_snap.sh)
# this script disables it back

sudo apt purge snapd --yes

echo "Package: snapd
Pin: release a=*
Pin-Priority: -10" | sudo tee /etc/apt/preferences.d/nosnap.pref

sudo apt update --yes
