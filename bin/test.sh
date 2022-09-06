#!/bin/bash

# this script runs docker container with an empty system as a test playground for scripts

docker build -f ~/dotfiles/Dockerfile -t dottest ~/dotfiles
docker run $@ -it dottest # ./test.sh --rm to remove container after exit
