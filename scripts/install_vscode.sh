#!/bin/bash

# install VS Code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code

# create symlinks for settings
ln -sf $HOME/dotfiles/vscode/settings.json $HOME/.config/Code/User/settings.json
ln -sf $HOME/dotfiles/vscode/keybindings.json $HOME/.config/Code/User/keybindings.json

# install extensions
code --install-extension bung87.rails
code --install-extension bung87.vscode-gemfile
code --install-extension castwide.solargraph
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension deniskoronchik.ostis
code --install-extension mikestead.dotenv
code --install-extension mjmcloug.vscode-elixir
code --install-extension monokai.theme-monokai-pro-vscode
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python
code --install-extension rebornix.ruby
code --install-extension redhat.vscode-yaml
code --install-extension shardulm94.trailing-spaces
code --install-extension sianglim.slim
code --install-extension waderyan.gitblame
code --install-extension yzhang.markdown-all-in-one

# output all installed extensions with install comand to copy-paste:
# code --list-extensions | xargs -L 1 echo code --install-extension
