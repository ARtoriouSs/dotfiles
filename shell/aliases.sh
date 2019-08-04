# git aliases
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
alias gst="git status"
alias gd="git diff"
alias gl="git log --pretty=format:\"%C(yellow bold)%h%Creset | %C(blue bold)%ad%Creset, %C(green bold)%an%Creset %s%C(red bold)%d%Creset\" --graph --date=relative"

# rails aliases
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

# docker aliases
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

# system aliases
alias cdp="cd $HOME/my_folder/projects"
alias c="cd .."
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rb="ruby"
alias n="nemo" # "nautilus"
alias nh="nemo . &" # "nautilus . &"
alias psqlc="sudo -u postgres psql"
alias todo="subl $HOME/todo.yml"
alias s="code"
alias ss="subl"
alias v="vim"
alias search="find . -name"
alias ho="heroku open"
alias upd="sudo apt-get --yes update"
alias upg="sudo apt-get --yes upgrade"
alias i="sudo apt-get --yes install"
alias install="sudo apt-get --yes update && sudo apt-get --yes install"
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias k9="kill -9"
alias susp="systemctl suspend"

# dotfiles quick access aliases
alias profile="subl $HOME/dotfiles/shell/.profile"
alias bashrc="subl $HOME/dotfiles/shell/.bashrc"
alias zprofile="subl $HOME/dotfiles/shell/.zprofile"
alias zshrc="subl $HOME/dotfiles/shell/.zshrc"
alias aliases="subl $HOME/dotfiles/shell/aliases.sh"
alias temp_settings="subl $HOME/dotfiles/shell/.temp_settings"
alias gitconfig="subl $HOME/dotfiles/.gitconfig"
alias gitignore_global="subl $HOME/dotfiles/.gitignore_global"
alias gitignore="subl $HOME/dotfiles/.gitignore_global"
alias vimrc="subl $HOME/dotfiles/vim/.vimrc"

# russian equivalents for wrong keyboard layout
alias "с"="cd .."
alias "св"="cd"
alias "свз"="cd $HOME/my_folder/projects"
alias "пые"="git status"
alias "ы"="code"
alias "ещвщ"="todo"

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
