source "$HOME/dotfiles/system/helpers.sh"
source "$HOME/dotfiles/git/helpers.sh"
source "$HOME/dotfiles/tmux/helpers.sh"
source "$HOME/dotfiles/development/helpers.sh"
source "$HOME/dotfiles/frogswamp/helpers.sh"

# private files from the dotfiles-secret repo (bin/clone_secret.sh), skipped when it's not cloned
# private_settings.sh should be last, it may override anything above
for file in helpers.sh credentials.sh private_settings.sh; do
  if [ -f "$HOME/dotfiles-secret/system/$file" ]; then
    source "$HOME/dotfiles-secret/system/$file"
  fi
done
