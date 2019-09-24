# git
alias g="git"
alias gcl="git clone"
alias grem="git remote"
alias gb="git branch"
alias gco="git checkout"
alias ga="git add"
alias gaa="git add --all"
alias "g[]"="git stash"
alias "g[]p"="git stash pop"
alias "g[]ps"="git stash push"
alias grh="git reset HEAD"
alias gsto="git status"
alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gp="git push"
alias gpl="git pull"
alias gupd="git rebase origin/master"
alias gf="git fetch"
alias fetch="git fetch origin"
alias gd="git diff"
alias gl="git log --pretty=format:\"%C(yellow bold)%h%Creset | %C(blue bold)%ad%Creset, %C(green bold)%an%Creset %s%C(red bold)%d%Creset\" --graph --date=relative"

# rails
alias r="rails"
alias rt="bundle exec rails test"
alias b="bundle"
alias be="bundle exec"
alias rs="bundle exec rails server"
alias rc="bundle exec rails console"
alias bi="bundle install"
alias bu="bundle update"
alias rr="bundle exec rake routes"
alias rdm="bundle exec rake db:migrate"
alias rdr="bundle exec rake db:drop db:create db:migrate"

# docker
alias d="docker"
alias dr="docker run"
alias dps="docker ps -a"
alias di="docker images -a"
alias drm="docker rm -f"
alias drmi="docker rmi -f"
alias drmall="docker rm -f $(docker ps -aq)"
alias dclear="docker system prune"
alias dcp="docker-compose"
alias dcps="docker-compose ps -a"

# system
alias cdp="cd $PROJECTS"
alias cdt="cd $PROJECTS/test"
alias c="cd .."
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias n="$FILE_MANAGER"
alias nh="$FILE_MANAGER . &"
alias psqlc="psql -U postgres"
alias todo="$WORK_EDITOR $HOME/todo.yml"
alias todol="$WORK_EDITOR todo.yml"
alias s="$WORK_EDITOR"
alias v=$EDITOR
alias search="find . -name"
alias ho="heroku open"
alias k9="kill -9"
alias now="date '+ %H:%M | %B %d'"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    alias upd="sudo apt-get --yes update"
    alias upg="sudo apt-get --yes upgrade"
    alias i="sudo apt-get --yes install"
    alias install="sudo apt-get --yes update && sudo apt-get --yes install"
    alias susp="systemctl suspend"
    alias shutdown="init 0"
    alias shut="init 0"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias i="brew install"
    alias install="brew install"
    alias susp="pmset sleepnow"
    alias shutdown="sudo halt"
    alias shut="sudo halt"
fi

# dotfiles quick access
alias cdd="cd ~/dotfiles"
alias profile="$WORK_EDITOR $HOME/dotfiles/shell/.profile"
alias bashrc="$WORK_EDITOR $HOME/dotfiles/shell/.bashrc"
alias zprofile="$WORK_EDITOR $HOME/dotfiles/shell/.zprofile"
alias zshrc="$WORK_EDITOR $HOME/dotfiles/shell/.zshrc"
alias aliases="$WORK_EDITOR $HOME/dotfiles/shell/aliases.sh"
alias functions="$WORK_EDITOR $HOME/dotfiles/shell/functions.sh"
alias environment="$WORK_EDITOR $HOME/dotfiles/shell/environment.sh"
alias temp_settings="$WORK_EDITOR $HOME/dotfiles/shell/temp_settings"
alias gitconfig="$WORK_EDITOR $HOME/dotfiles/.gitconfig"
alias gitignore_global="$WORK_EDITOR $HOME/dotfiles/.gitignore_global"
alias gitignore="$WORK_EDITOR $HOME/dotfiles/.gitignore_global"
alias vimrc="$WORK_EDITOR $HOME/dotfiles/vim/.vimrc"

# some russian equivalents for wrong keyboard layout
alias "с"="cd .."
alias "св"="cd"
alias "свз"="cdp"
alias "пые"="gst"
alias "ы"="s"
alias "ещвщ"="todo"
alias "ещвщд"="todol"
# some caps equivalents
alias "C"="c"
alias "CD"="cd"
alias "CDP"="cdp"
alias "GST"="gst"
alias "S"="s"
alias "TODO"="todo"
alias "TODOL"="todol"

# enable color support of ls and also add handy aliases from default .bashrc
if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
