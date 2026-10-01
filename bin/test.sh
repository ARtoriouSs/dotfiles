#!/bin/bash

# this script runs docker container with an empty system as a test playground
# GUI apps open as windows on the host display (run xeyes to check),
# use --no-sandbox flag for electron/chromium based things e.g. google-chrome/insomnia/discord
#
# ./test.sh --rm to remove container after exit

if [ -z "$DISPLAY" ]; then
  echo "DISPLAY is not set, run it from a graphical session"
  exit 1
fi

# X cookie for the container, "ffff" family makes it valid for any hostname
XAUTH=/tmp/.dottest.xauth
umask 077
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# GPU acceleration if available
GPU=()
if [ -d /dev/dri ]; then
  GPU=(--device /dev/dri --group-add $(getent group render | cut -d: -f3))
fi

docker build -f ~/dotfiles/Dockerfile -t dottest \
  --build-arg UID=$(id -u) --build-arg GID=$(id -g) ~/dotfiles

docker run "$@" -it \
  --hostname dottest \
  --shm-size=2g \
  "${GPU[@]}" \
  -e DISPLAY \
  -e XAUTHORITY=/tmp/.docker.xauth \
  -v $XAUTH:/tmp/.docker.xauth:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  dottest
