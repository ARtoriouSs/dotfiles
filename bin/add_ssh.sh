#!/bin/bash
set -o pipefail # a pipeline fails when any command in it fails, not only the last one

# generates an ed25519 ssh key, adds it to the ssh agent and copies the public key to the clipboard
# an existing key is never overwritten

source ~/dotfiles/system/helpers.sh # source clip function

key=~/.ssh/id_ed25519
email=$1

if [ -z "$1" ]; then
  if [ -z "$EMAIL" ]; then
    echo "provide your email as a first argument:"
    echo "    ./add_ssh.sh my_email@example.com"
    echo "otherwise it should be in \$EMAIL"
    exit 1
  fi
  if [[ "$EMAIL" == "email@example.com" ]]; then
    echo "\$EMAIL is a default placeholder email, set \$EMAIL or provide it as a first argument"
    exit 1
  fi
  email=$EMAIL
fi

if [ -e "$key" ]; then
  echo "$key already exists, nothing was changed"
  exit 1
fi

mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t ed25519 -C "$email" -f "$key" || exit 1 # asks for a passphrase, better not to leave it empty

# use the agent of the desktop session (gnome-keyring), start a new one only when there is none
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"
ssh-add "$key"

# copy
clip "$key.pub"
echo "ssh key has been copied to clipboard."
