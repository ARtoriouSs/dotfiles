#!/bin/bash

# TODO: for macOS
check() {
  if command -v $1 &> /dev/null; then
    printf " $(tput setaf 10)✓  "
  else
    printf " $(tput setaf 9)✗  "
  fi
  printf "$1 $(tput sgr0)\n"
}

check python
check python2
check python3
check pip
check pip2
check pip3

check ruby
check rbenv

check erl
check kiex

check node
check npm
check n
check yarn

check docker
check docker-compose

check psql
check redis-server
check redis-cli

check cowsay
check rg
check ag
check tmux
check ctags
check markdown
check nvim
check zsh

# check snap
if command -v snap &> /dev/null; then
  printf " $(tput setaf 10)✓  snap"
else
  if test -f "/etc/apt/preferences.d/nosnap.pref"; then
    echo " $(tput setaf 10)✓  snap disabled$(tput sgr0)"
  else
    printf " $(tput setaf 9)✗  snap\n"
  fi
fi

echo "checking shell:"
if [ -z "$RC_SOURCED" ]; then
  echo "    $(tput setaf 9)shell rc file is not sourced$(tput sgr0)"
else
  echo "    $(tput setaf 10)shell rc file is sourced$(tput sgr0)"
fi

if [ -z "$PROFILE_SOURCED" ]; then
  echo "    $(tput setaf 9)shell profile is not sourced, check if you are running login shell$(tput sgr0)"
else
  echo "    $(tput setaf 10)shell profile is sourced$(tput sgr0)"

  # check dir tree if environment sourced
  if [ -d $MY_FOLDER ]; then
    echo "    $(tput setaf 10)dir tree created$(tput sgr0)"
  else
    echo "    $(tput setaf 9)dir tree is not created$(tput sgr0)"
  fi
fi
