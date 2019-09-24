# base software
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    apt-get update
    apt-get upgrade
    apt-get install software-properties-common apt-transport-https wget curl snapd
elif [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" # homebrew
    brew tap caskroom/cask # cask
    brew install curl wget
fi

# more
if [[ "$OSTYPE" == "linux-gnu" ]]; then
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
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # iterm
    brew cask install iterm2
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
fi

if [[ "$OSTYPE" == "dVarwin"* ]]; then
    touch ~/.hushlogin # do not display login message
    defaults write NSGlobalDomain KeyRepeat -int 0 # increase cursor repeat speed
fi
