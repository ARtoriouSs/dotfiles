# VS Code settings

Use [this script](../scripts/install_vscode.sh) to install and configure VS Code. You will need to install VS Code manually when running on MacOS and then configure it by running [configure_vscode.sh](../scripts/configure_vscode.sh).

To output all installed extensions with install command to copy-paste:

```bash
code --list-extensions | xargs -L 1 echo code --install-extension
```
