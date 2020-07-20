#!/bin/bash

# prerequirements
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  sudo apt-get update --yes
  sudo apt-get upgrade --yes
  sudo apt-get install --yes software-properties-common apt-transport-https wget curl snapd xclip libcurl4-openssl-dev apt-utils
elif [[ "$OSTYPE" == "darwin"* ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # homebrew
  brew doctor # make sure brew has permissions
  brew update
  brew tap caskroom/cask # cask
  brew install curl wget coreutils
fi

# more
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # python and pip
  sudo apt-get install --yes python2.7 python3 python3-pip
  curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
  sudo python2 get-pip.py
  rm get-pip.py
  # ruby
  sudo apt-get install --yes ruby-full
  # erlang
  wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | apt-key add -
  echo "deb https://packages.erlang-solutions.com/ubuntu bionic contrib" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
  sudo apt-get install --yes erlang
  # cowsay :)
  sudo apt-get install --yes cowsay
  # ripgrep
  sudo apt-get install ripgrep
  # tmux
  sudo apt-get install --yes tmux
  # node and npm (may need to update version below)
  apt-get install --yes npm
  npm update npm -g # updates npm
  npm install -g n
  sudo mkdir -p /usr/local/n
  sudo chown -R $(whoami) /usr/local/n
  sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
  n latest
  # docker
  sudo apt-get install --yes apt-transport-https ca-certificates
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  sudo apt-get update
  sudo apt-get install --yes docker-ce docker-ce-cli containerd.io
  # docker-compose
  curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  # postgres
  sudo apt-get install --yes ca-certificates
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
  sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
  sudo apt-get update
  sudo apt-get install --yes postgresql postgresql-contrib postgresql-common
  # redis
  sudo apt-get install --yes redis-server
  sudo systemctl enable redis-server.service # run redis on boot
  # yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -~
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get update
  sudo apt-get install --yes yarn
  # ctags TODO: install via apt when available
  sudo apt-get --yes install pkg-config autoconf # prerequirements
  git clone https://github.com/universal-ctags/ctags.git ctags_source
  cd ctags_source
  ./autogen.sh
  ./configure
  sudo make
  sudo make install
  cd -
  rm -rf ctags_source
  # markdown
  sudo apt-get install --yes markdown
  # fix dependensies
  apt --fix-broken install --yes
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # pip
  easy_install pip
  pip install --upgrade pip
  # ruby
  brew install ruby
  # erlang
  brew install erlang
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
  # postgres
  brew install postgres
  # redis
  brew install redis
  ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents # run redis on boot
  # yarn
  brew install yarn
  # ctags TODO: standard install via brew when available
  brew uninstall ctags # remove default ctags
  brew install --HEAD universal-ctags/universal-ctags/universal-ctags
fi

# kiex
curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s
# diff-so-fancy
wget -P /usr/local/bin https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
sudo chmod +x /usr/local/bin/diff-so-fancy
