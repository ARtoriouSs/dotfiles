#!/bin/bash

# TODO: macOS
check() {
  if command -v $1 &> /dev/null; then
    printf " $(tput setaf 10)✓  "
  else
    printf " $(tput setaf 9)✗  "
  fi
  printf "$1 $(tput sgr0)\n"
}

# check if snap enabled and installed
# TODO: macOS
check-snap() {
  if command -v snap &> /dev/null; then
    printf " $(tput setaf 10)✓  snap"
  else
    if test -f "/etc/apt/preferences.d/nosnap.pref"; then
      echo " $(tput setaf 10)✓  snap disabled$(tput sgr0)"
    else
      printf " $(tput setaf 9)✗  snap\n$(tput sgr0)"
    fi
  fi
}

echo "CLI base:"
check zsh
check nvim
check ctags
check tmux
check rg
check ag
check markdown
check cowsay
check-snap

echo "Python:"
check python
check python2
check python3
check pip
check pip2
check pip3

echo "Ruby:"
check ruby
check rbenv

echo "Erlang and Elixir:"
check erl
check kiex

echo "JavaScript:"
check node
check npm
check n
check yarn

echo "Docker:"
check docker
check docker-compose

echo "Databases:"
check psql
check redis-server
check redis-cli

echo "GUI apps:"
check google-chrome
check telegram-desktop
check skypeforlinux
check slack
check discord

printf "\nChecking shell:\n"
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
