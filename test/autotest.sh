#!/bin/bash

# this script will run docker container with an empty system and then prepare_system.sh in it

if [ "$1" = "--osx" ] || [ "$1" = "--macos" ]; then
  echo "not supported, https://github.com/Cleafy/sxkdvm can be the way to go"
else
  docker build -f ~/dotfiles/test/Dockerfile -t dottest-all ~/dotfiles
  docker run dottest-all "sudo ./scripts/prepare_system.sh"
fi
