#!/bin/bash

set -o pipefail # a pipeline fails when any command in it fails, not only the last one

# clones the private dotfiles-secret repo to ~/dotfiles-secret and links its files, safe to re-run
# over HTTPS git asks for a username and a password, the password is a GitHub personal access token
# without the repo everything works with the default files

secret_dir=~/dotfiles-secret
github_username=${GITHUB_USERNAME:-ARtoriouSs} # environment.sh may be not loaded yet on a fresh system

if [ -d "$secret_dir/.git" ]; then
  echo "$secret_dir is already cloned"
elif ! git clone "https://github.com/$github_username/dotfiles-secret.git" "$secret_dir"; then
  echo "Couldn't clone dotfiles-secret, continuing without private files, run bin/clone_secret.sh later" >&2
  exit 0
fi

git -C "$secret_dir" remote set-url origin "git@github.com:$github_username/dotfiles-secret.git" # SSH from now on, like this repo
git -C "$secret_dir" config core.hooksPath ~/dotfiles/.githooks # the same gitleaks check as here

if ! "$secret_dir"/bin/credentials.sh decrypt; then
  echo "Credentials are not decrypted, run secret-decrypt when age and the key are in place" >&2
fi

~/dotfiles/bin/create_symlinks.sh
