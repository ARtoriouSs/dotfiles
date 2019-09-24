#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # none
elif [[ "$OSTYPE" == "darwin"* ]]; then
    touch ~/.hushlogin # do not display login message
    defaults write NSGlobalDomain KeyRepeat -int 0 # increase cursor repeat speed
fi
