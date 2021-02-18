#!/bin/bash

# this script will run docker container with an empty system as a test playground for scripts

docker build -f ~/dotfiles/test/Dockerfile -t dottest ~/dotfiles
docker run -it dottest
