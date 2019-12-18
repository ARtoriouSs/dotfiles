#!/bin/bash

# install VS Code
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install code
    ./configure_vscode.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew cask install visual-studio-code
    ./configure_vscode.sh
fi
