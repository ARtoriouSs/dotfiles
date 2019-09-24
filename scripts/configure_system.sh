#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # none
elif [[ "$OSTYPE" == "darwin"* ]]; then
    touch ~/.hushlogin # do not display login message
    defaults write -g KeyRepeat -int 0 # increase cursor repeat speed when holding arrow key (minimum in settings 2)
    defaults write -g InitialKeyRepeat -int 10 # decreace delay before repeat starts (minimum in settings 15)
fi
