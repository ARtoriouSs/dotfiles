#!/bin/bash

source ~/dotfiles/shell/functions.sh # source clip function

if [ -z "$1" ] | [ -z "$EMAIL" ]; then
  echo "provide your email as a first argument:"
  echo "    ./add_ssh.sh my_email@example.com"
  echo "otherwise it should be in \$EMAIL"
  exit 1
fi

ssh-keygen -t rsa -b 4096 -C $1
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa

# copy
clip ~/.ssh/id_rsa.pub
echo "ssh key has been copied to clipboard."
