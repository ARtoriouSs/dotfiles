#!/bin/bash

source ~/dotfiles/system/helpers.sh # source clip function

email=$1

if [ -z "$1" ]; then
  if [ -z "$EMAIL" ]; then
    echo "provide your email as a first argument:"
    echo "    ./add_ssh.sh my_email@example.com"
    echo "otherwise it should be in \$EMAIL"
    exit 1
  fi
  email=$EMAIL
fi

ssh-keygen -t rsa -b 4096 -C $email
chmod 400 ~/.ssh/id_rsa
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa

# copy
clip ~/.ssh/id_rsa.pub
echo "ssh key has been copied to clipboard."
