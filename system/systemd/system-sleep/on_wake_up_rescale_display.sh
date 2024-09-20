#!/bin/bash

# Should be symlinked to /lib/systemd/system-sleep (will not be linked automatically)

case $1/$2 in
  post/*)
    # Enable fractional scaling in GNOME (if running on a huge screen):"
    # https://askubuntu.com/questions/1029436/enable-fractional-scaling-for-ubuntu-18-04
    # https://askubuntu.com/a/1056366/1113014
    # xrandr --istmonitors to see the available displays

    xrandr --output DP-4 --scale 1.5x1.5
  ;;
esac
