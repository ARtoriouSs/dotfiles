#!/bin/bash

# base software
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  apt-get update
  apt-get upgrade
  apt-get install software-properties-common apt-transport-https wget curl snapd git-core python3-pip
elif [[ "$OSTYPE" == "darwin"* ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # homebrew
  brew doctor # make sure brew has permissions
  brew update
  brew tap caskroom/cask # cask
  brew install curl wget git
  # pip
  easy_install pip
  pip install --upgrade pip
fi

# more
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # cowsay :)
  apt-get install cowsay
  # ripgrep
  snap install ripgrep --classic
  # tmux
  apt-get install tmux
  # node
  curl -sL https://deb.nodesource.com/setup_12.x | -E bash -
  apt-get install nodejs
  npm update npm -g # updates npm
  # docker
  apt-get install apt-transport-https ca-certificates
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  apt-get update
  apt-get install docker-ce docker-ce-cli containerd.io
  # docker-compose
  curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  # rbenv
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src # Can fail, it's ok
  ~/.rbenv/bin/rbenv init
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash # verify rbenv
  # ruby-build for rbenv
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  # postgres
  apt-get install wget ca-certificates
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
  apt-get update
  apt-get install postgresql postgresql-contrib
  pg_ctl -D /usr/local/var/postgres start # start server
  # redis
  apt-get install redis-server
  systemctl enable redis-server.service # run redis on boot
  # chrome
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome-stable_current_amd64.deb
  # telegram
  snap install telegram-desktop
  # skype
  snap install skype --classic
  # slack
  snap install slack --classic
  # yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -~
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
  apt-get update
  apt-get install yarn
  # diff-so-fancy
  wget -P /usr/local/bin https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
  chmod +x /usr/local/bin/diff-so-fancy
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # cowsay :)
  brew install cowsay
  # ripgrep
  brew install ripgrep
  # iterm
  brew cask install iterm2
  # tmux
  brew install tmux
  # node
  brew install node
  npm update npm -g # updates npm
  # docker with docker-compose
  brew cask install docker
  # rbenv
  brew install rbenv
  rbenv init
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash # verify rbenv
  # postgres
  brew install postgres
  brew services start postgresql # start server
  # redis
  brew install redis
  ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents # run redis on boot
  # chrome
  brew cask install google-chrome
  # telegram
  brew cask install telegram
  # skype
  brew cask install skype
  # slack
  brew cask install slack
  # yarn
  brew install yarn
  # diff-so-fancy
  wget -P /usr/local/bin https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
  chmod +x /usr/local/bin/diff-so-fancy
fi
