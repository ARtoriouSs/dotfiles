#!/bin/bash

# prerequirements
sudo apt update --yes
sudo apt upgrade --yes
sudo apt install --yes software-properties-common apt-transport-https libcurl4-openssl-dev apt-utils libssl-dev libreadline-dev wget curl git xclip

# python and pip
sudo apt install --yes python2 python2.7 python3 python3-pip
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py # pip3
sudo python3 get-pip.py
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py # pip2
sudo python2 get-pip.py
rm get-pip.py
# ruby
sudo apt install --yes ruby-full
# cowsay :)
sudo apt install --yes cowsay
# ripgrep
sudo apt install --yes ripgrep
# ag
sudo apt install --yes silversearcher-ag
# tmux
sudo apt install --yes tmux
# zellij
curl https://sh.rustup.rs -sSf | sh
cargo install --locked zellij
# node and npm
sudo apt install --yes npm
npm update npm -g # update npm
sudo npm install -g n
sudo mkdir -p /usr/local/n
sudo chown -R $(whoami) /usr/local/n
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
n latest
# docker
sudo apt install --yes ca-certificates python3-requests # prerequirements
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install --yes docker-ce docker-ce-cli
sudo groupadd docker
sudo usermod -aG docker ${USER} # add current user to docker user group
# docker-compose
curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# postgres
sudo apt install --yes ca-certificates libpq-dev
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt update
sudo apt install --yes postgresql postgresql-contrib postgresql-common
# redis
sudo apt install --yes redis-server
sudo systemctl enable redis-server.service # run redis on boot
# yarn
sudo npm install -g yarn
# ctags TODO: install via apt when available (https://github.com/universal-ctags/ctags)
sudo apt install --yes pkg-config autoconf # prerequirements
git clone https://github.com/universal-ctags/ctags.git ctags_source
cd ctags_source
./autogen.sh
./configure
sudo make
sudo make install
cd -
rm -rf ctags_source
# markdown
sudo apt install --yes markdown
# github CLI
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
# asdf (configured via ZSH plugin)
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
# kerl
curl https://raw.githubusercontent.com/kerl/kerl/master/kerl -o /usr/local/bin/kerl
chmod a+x /usr/local/bin/kerl
# kiex
curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s
# diff-so-fancy
git clone https://github.com/so-fancy/diff-so-fancy.git ~/my_folder/bin/diff-so-fancy # diff-so-fancy
sudo chmod +x ~/my_folder/bin/diff-so-fancy/diff-so-fancy
# jq
sudo apt install --yes jq
