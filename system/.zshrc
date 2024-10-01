export RC_SOURCED=true # for healthcheck script

# zsh-specific variables
export ZSH_THEME="chaotic-beef" # theme
export CASE_SENSITIVE="true"
export LANG=en_US.UTF-8
export ZSH=$HOME/.oh-my-zsh

# autosuggestion and completion
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=94'
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export COMPLETION_WAITING_DOTS="true" # display dots when completion is loading

# initialize oh-my-zsh
source $ZSH/oh-my-zsh.sh

# plugins
plugins=(
  git
  asdf
  zsh-autosuggestions
  zsh-syntax-highlighting # must be the last in this list
)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U compinit
compinit -i

bindkey -M emacs "^[[3;5~" kill-word # ctrl + delete
bindkey -M emacs "^H" backward-kill-word # ctrl + backspace

# disable oh-my-zsh aliases
unalias -m '*'

# load specific helpers
source "$HOME/dotfiles/system/initializer.sh"
