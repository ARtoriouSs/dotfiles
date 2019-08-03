# zsh-specific variables
ZSH_THEME="chaotic-beef"
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
export LANG=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh

# initialization
## oh-my-zsh
source $ZSH/oh-my-zsh.sh

## rbenv
eval "$(rbenv init -)"

## kiex
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# plugins
plugins=(
  git
  zsh-syntax-highlighting # must be the last in this list
)

# disable oh-my-zsh aliases
unalias -m '*'

# import helper functions
if [ -f "$HOME/dotfiles/shell/functions.sh" ]; then
    . "$HOME/dotfiles/shell/functions.sh"
fi

# import aliases
if [ -f "$HOME/dotfiles/shell/aliases.sh" ]; then
    . "$HOME/dotfiles/shell/aliases.sh"
fi

# import temp settings (e.g. for current project)
if [ -f "$HOME/dotfiles/shell/temp_settings.sh" ]; then
    . "$HOME/dotfiles/shell/temp_settings.sh"
fi
