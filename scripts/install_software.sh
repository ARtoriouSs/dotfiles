#!/bin/bash

# base software
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  apt-get update --yes
  apt-get upgrade --yes
  apt-get install --yes software-properties-common apt-transport-https wget curl snapd git-core python3-pip
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
  # ruby
  apt-get install --yes ruby-full
  # cowsay :)
  apt-get install --yes cowsay
  # ripgrep
  snap install ripgrep --classic
  # tmux
  apt-get install --yes tmux
  # node (may need to update version below)
  curl -sL https://deb.nodesource.com/setup_13.x | bash -
  apt-get install --yes nodejs
  npm update npm -g # updates npm
  # docker
  apt-get install --yes apt-transport-https ca-certificates
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  apt-get update
  apt-get install --yes docker-ce docker-ce-cli containerd.io
  # docker-compose
  curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  # rbenv
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src # can fail, it's ok
  ~/.rbenv/bin/rbenv init
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash # verify rbenv
  # ruby-build for rbenv
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  # postgres
  apt-get install --yes ca-certificates
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
  apt-get update
  apt-get install --yes postgresql postgresql-contrib postgresql-common
  # redis
  apt-get install --yes redis-server
  systemctl enable redis-server.service # run redis on boot
  # yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -~
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
  apt-get update
  apt-get install --yes yarn
  # diff-so-fancy
  wget -P /usr/local/bin https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
  chmod +x /usr/local/bin/diff-so-fancy
  # ctags TODO: install via apt when available
  git clone https://github.com/universal-ctags/ctags.git ctags_source
  cd ctags_source
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd ..
  rm -rf ctags_source
  # markdown
  apt-get install --yes markdown
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # ruby
  brew install ruby
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
  # yarn
  brew install yarn
  # diff-so-fancy
  wget -P /usr/local/bin https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
  chmod +x /usr/local/bin/diff-so-fancy
  # ctags TODO: standatd install via brew when available
  brew uninstall ctags # remove default ctags
  brew install --HEAD universal-ctags/universal-ctags/universal-ctags
  # markdown
  brew install markdown
fi
