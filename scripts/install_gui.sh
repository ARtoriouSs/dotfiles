#!/bin/bash

# this script shouldn't be run in non-gui environment like docker to not brake dependensies

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # chrome
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb
  # telegram
  snap install telegram-desktop
  # skype
  snap install skype --classic
  # slack
  snap install slack --classic
  # fix dependensies
  apt --fix-broken install --yes
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # chrome
  brew cask install google-chrome
  # telegram
  brew cask install telegram
  # skype
  brew cask install skype
  # slack
  brew cask install slack
fi
