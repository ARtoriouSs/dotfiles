# import environment variables. Should be first
if [ -f "$HOME/dotfiles/shell/environment.sh" ]; then
  . "$HOME/dotfiles/shell/environment.sh"
fi

# include bashrc
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
