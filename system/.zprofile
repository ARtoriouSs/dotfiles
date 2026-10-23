export PROFILE_SOURCED=true # for healthcheck script

# Import environment variables. Should be first
source "$HOME/dotfiles/system/environment.sh"

# zsh sources .zshrc by itself after .zprofile in login shells, so it's not sourced here
