#!/bin/bash

# a script to allow the Keychron K2/K4 keyboard to boot up with function keys enabled
# https://github.com/Diolinux/keychron-k2-k4-function-keys-linux

sudo cp system/hardware/keychron.service /etc/systemd/system/keychron.service
sudo systemctl enable keychron
