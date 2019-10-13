# create symlinks for settings
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    ln -sf ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
    ln -sf ~/dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ln -sf ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln -sf ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/settings.json
fi

# install extensions
# use the following command to output all installed extensions prepended with install comand and make list like below:
# code --list-extensions | xargs -L 1 echo code --install-extension
code --install-extension bung87.rails
code --install-extension bung87.vscode-gemfile
code --install-extension castwide.solargraph
code --install-extension CraigMaslowski.erb
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension deniskoronchik.ostis
code --install-extension karunamurti.haml
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
