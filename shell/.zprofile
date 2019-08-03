# Import environment variables. Should be first
if [ -f "$HOME/dotfiles/shell/environment.sh" ]; then
    . "$HOME/dotfiles/shell/environment.sh"
fi

# Initialize zsh
if [ -n "$ZSH_VERSION" ]; then
    if [ -f "$HOME/.zshrc" ]; then
        . "$HOME/.zshrc"
    fi
fi
