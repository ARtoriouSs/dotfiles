export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.rbenv/bin:/usr/games:$PATH
export PATH=$HOME/.rbenv/bin:$PATH # rbenv
export PATH=.git/safe/../../bin:$PATH # git-safe

# variables
export DOTFILES_VIM=~/dotfiles/vim/ # dotfiles vim configuration location
export VISUAL=nvim
export EDITOR=ex
export GREP_TOOL=rg
export SSH_KEY_PATH=~/.ssh/id_rsa
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01' # colored GCC warnings and errors
export TERM=xterm-256color # use 256 colors

# fuzzy search
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# logins
export GITHUB_USERNAME=ARtoriouSs
export GITLAB_USERNAME=ARtoriouS
export BITBACKET_USERNAME=ARtoriouS

# directories and files access
export MY_FOLDER=~/my_folder
export PROJECTS=~/my_folder/projects
export TODO=~/todo.yml

### initializations

# dircolors
if [ -x /usr/bin/dircolors ]; then
  test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
fi

eval "$(rbenv init -)" # rbenv

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex" # kiex
