export PROFILE_SOURCED=true # for healthcheck script

# Import environment variables. Should be first
source "$HOME/dotfiles/shell/environment.sh"

# Initialize zsh
if [ -n "$ZSH_VERSION" ]; then
  if [ -f "$HOME/.zshrc" ]; then
    . "$HOME/.zshrc"
  fi
fi
