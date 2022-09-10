#!/bin/bash

# this script runs docker container with an empty system as a test playground
# it has GUI apps support, however use --no-sandbox flag
# for electron/chromium based things e.g. google-chrome/insomnia/discord
#
# ./test.sh --rm to remove container after exit

xhost +
docker build -f ~/dotfiles/Dockerfile -t dottest ~/dotfiles
docker run $@ -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro dottest
xhost -
