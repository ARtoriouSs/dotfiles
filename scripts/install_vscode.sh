#!/bin/bash

# install VS Code
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install code
    ./configure_vscode.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "You need to install VS Code manualy on MacOS: https://appdividend.com/2018/03/17/how-to-install-visual-studio-code-on-mac/"
    echo "Then run ./configure_vscode.sh"
fi
