#!/bin/bash

# Should be symlinked to /lib/systemd/system-sleep

case $1/$2 in
  post/*)
    # Restore keyboard repeat delay and speed
    # https://askubuntu.com/questions/1086780/keyboard-repeat-delay-is-reset-occasionally-in-ubuntu-18-04
    gsettings set org.gnome.desktop.peripherals.keyboard delay 200
    xset r rate 200 40
  ;;
esac
