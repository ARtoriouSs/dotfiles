#!/bin/bash

# this script will run docker container with an empty system and then prepare_system.sh in it

if [ "$1" = "--osx" ] || [ "$1" = "--macos" ]; then
  echo "not supported, https://github.com/Cleafy/sxkdvm can be a way to go"
else
  docker build -f ~/dotfiles/test/Dockerfile -t dottest-all ~/dotfiles
  docker run dottest-all "echo pass | ./scripts/prepare.sh --skip-login-warn"
fi
