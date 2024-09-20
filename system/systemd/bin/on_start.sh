#!/bin/bash

# System start up script
# Should be symlinked to /usr/local/bin/on_start.sh by configure_system.sh

# Restore keyboard repeat delay and speed
# https://askubuntu.com/questions/1086780/keyboard-repeat-delay-is-reset-occasionally-in-ubuntu-18-04
echo bar > /tmp/on_start.log
gsettings set org.gnome.desktop.peripherals.keyboard delay 200
xset r rate 200 40
