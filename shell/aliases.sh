# git
alias g="git"
alias gcl="git clone"
alias grem="git remote"
alias gb="git branch"
alias gco="git checkout"
alias gca="git commit --amend"
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
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

# npm
alias n="npm"
alias nr="npm run"
alias ni="npm install"
alias ns="npm run start"
alias nt="npm run test"

# docker
alias d="docker"
alias dr="docker run"
alias dps="docker ps -a"
alias di="docker images -a"
alias drm="docker rm -f"
alias drmi="docker rmi -f"
alias dclear="docker system prune"
alias dcp="docker-compose"
alias dcps="docker-compose ps -a"

# system
alias e="echo"
alias c="cd .."
alias cls="clear"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias psqlc="psql -U postgres"
alias todo="$WORK_EDITOR $TODO"
alias todol="$WORK_EDITOR todo.yml"
alias s=$WORK_EDITOR
alias v=$EDITOR
alias search="find . -name"
alias ho="heroku open"
alias k9="kill -9"
alias now="date '+ %H:%M | %B %d'"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias upd="sudo apt-get --yes update"
    alias upg="sudo apt-get --yes upgrade"
    alias install="sudo apt-get --yes update && sudo apt-get --yes install"
    alias i="sudo apt-get --yes install"

    alias susp="systemctl suspend"
    alias shut="init 0"
    alias halt="init 0"

    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias install="brew install"
    alias i="brew install"

    alias susp="pmset sleepnow"
    alias shut="sudo halt"
    alias halt="sudo halt"
    alias init="sudo halt"
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
alias temp_settings="$WORK_EDITOR $HOME/dotfiles/shell/temp_settings.sh"
alias temp-settings="$WORK_EDITOR $HOME/dotfiles/shell/temp_settings.sh"
alias gitconfig="$WORK_EDITOR $HOME/dotfiles/.gitconfig"
alias gitignore_global="$WORK_EDITOR $HOME/dotfiles/.gitignore_global"
alias gitignore-global="$WORK_EDITOR $HOME/dotfiles/.gitignore_global"
alias gitignore="$WORK_EDITOR $HOME/dotfiles/.gitignore_global"
alias vimrc="$WORK_EDITOR $HOME/dotfiles/vim/.vimrc"

# some russian equivalents for wrong keyboard layout
alias "с"="cd .."
alias "св"="cd"
alias "свз"="cdp"
alias "свс"="cd $PROJECTS/$CURRENT_PROJECT"
alias "пые"="gst"
alias "ы"="s"
alias "ещвщ"="todo"
alias "ещвщд"="todol"
# some caps equivalents
alias "C"="c"
alias "CD"="cd"
alias "CDP"="cdp"
alias "CDC"="cd $PROJECTS/$CURRENT_PROJECT"
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
    alias grep="`which grep` --color=auto"
    alias fgrep="`which fgrep` --color=auto"
    alias egrep="`which egrep` --color=auto"
fi
