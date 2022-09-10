#!/bin/bash

# this script runs docker container with an empty system as a test playground
# ./test.sh --rm to remove container after exit

docker build -f ~/dotfiles/Dockerfile -t dottest ~/dotfiles
docker run $@ -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro dottest
