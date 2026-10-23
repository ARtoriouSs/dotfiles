#!/bin/bash
set -o pipefail # a pipeline fails when any command in it fails, not only the last one

# Mint has its own codename; the Ubuntu one picks the right apt repo
ubuntu_codename() {
  (. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
}

# prerequirements
sudo apt update --yes
sudo apt upgrade --yes
sudo apt install --yes software-properties-common apt-transport-https libcurl4-openssl-dev apt-utils libssl-dev libreadline-dev wget curl git xclip jq # jq is used by the gitlab CLI install below

# htop
sudo apt install --yes htop
# python and pip
sudo apt install --yes python3 python3-pip
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1 # python = python3
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1 # pip = pip3
# ruby
sudo apt install --yes ruby-full ruby-bundler
sudo gem update bundler # gems of the system ruby belong to root
# go
sudo apt install --yes golang-go
# cowsay :)
sudo apt install --yes cowsay
# ripgrep
sudo apt install --yes ripgrep
# ag
sudo apt install --yes silversearcher-ag
# fzf
sudo apt install --yes fzf
# tmux
sudo apt install --yes tmux
# rust (provides cargo for rtk and friends)
curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
# node and npm
# n keeps node in ~/.n, so global npm packages need neither sudo nor a user owned /usr/local
# (root runs binaries from /usr/local/bin, so it must stay writable only by root)
sudo apt install --yes npm
sudo npm install -g n
export N_PREFIX="$HOME/.n" PATH="$HOME/.n/bin:$PATH" # same as in system/environment.sh, for the rest of this script
n lts # latest can be ahead of native addons, e.g. better-sqlite3 for caveman
# apt repo keys, each one trusted only for its own repo (signed-by)
sudo install -m 0755 -d /etc/apt/keyrings
# docker
sudo apt install --yes ca-certificates python3-requests # prerequirements
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(ubuntu_codename) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install --yes docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin # compose is `docker compose`
sudo groupadd docker
sudo usermod -aG docker ${USER} # add current user to docker user group
# postgres
sudo apt install --yes ca-certificates libpq-dev
sudo curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc -o /etc/apt/keyrings/postgresql.asc
sudo chmod a+r /etc/apt/keyrings/postgresql.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/postgresql.asc] https://apt.postgresql.org/pub/repos/apt $(ubuntu_codename)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list > /dev/null
sudo apt update
sudo apt install --yes postgresql postgresql-contrib postgresql-common
# redis
sudo apt install --yes redis-server
sudo systemctl enable redis-server.service # run redis on boot
# yarn
npm install -g --allow-scripts=yarn yarn
# markdown
sudo apt install --yes markdown
# github CLI
sudo curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg -o /etc/apt/keyrings/githubcli-archive-keyring.gpg
sudo chmod a+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install --yes gh
# gitlab CLI
GLAB_VERSION=$(curl -sL "https://gitlab.com/api/v4/projects/gitlab-org%2Fcli/releases/permalink/latest" | jq -r .tag_name | sed 's/^v//')
curl -sL "https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_amd64.deb" -o /tmp/glab.deb
sudo apt install --yes /tmp/glab.deb
rm /tmp/glab.deb
# gitleaks, secret scanner for the pre-commit hook in .githooks
~/dotfiles/bin/install_gitleaks.sh
# AI agents (claude, codex, gemini, copilot) are installed by install_ai_agents.sh
# asdf (configured via ZSH plugin)
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
make
cd -
# kerl
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/kerl/kerl/master/kerl -o ~/.local/bin/kerl
chmod a+x ~/.local/bin/kerl
# kiex
curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/kiex | bash -s install_kiex
# diff-so-fancy
git clone https://github.com/so-fancy/diff-so-fancy.git ~/my_folder/bin/diff-so-fancy # diff-so-fancy
sudo chmod +x ~/my_folder/bin/diff-so-fancy/diff-so-fancy
# grub-customizer
sudo add-apt-repository -y ppa:danielrichter2007/grub-customizer
sudo apt update
sudo apt install --yes grub-customizer
