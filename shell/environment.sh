export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.rbenv/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH # for mac ports
export PATH=.git/safe/../../bin:$PATH # git-safe
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH" # VS Code on MacOS
fi

# variables
export DOTFILES_PATH=~/dotfiles
export DOTFILES_VIMRC=$DOTFILES_PATH/vim/.vimrc # dotfiles copy of vimrc
export EDITOR=nvim
export GREP_TOOL=rg
export SSH_KEY_PATH=~/.ssh/id_rsa
export TERM=xterm-256color # use 256 colors

# fuzzy search
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# logins
export GITHUB_USERNAME=ARtoriouSs
export GITLAB_USERNAME=ARtoriouS
export BITBACKET_USERNAME=ARtoriouS

# directories and files access
export MY_FOLDER=~/my_folder
export PROJECTS=~/my_folder/projects
export DESKTOP=~/Desktop
export TODO=~/todo.yml
