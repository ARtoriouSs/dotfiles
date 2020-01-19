# git
alias g="git"
alias ginit="git init"
alias gcl="git clone"
alias gb="git branch"
alias gco="git checkout"
alias gca="git commit --amend"
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gm="git megre"
alias gmc="git megre --continue"
alias gma="git merge --abort"
alias gf="git fetch"
alias fetch="git fetch origin"
alias gd="git diff"
alias gl="git log --pretty=format:\"%C(yellow bold)%h%Creset | %C(blue bold)%ad%Creset, %C(green bold)%an%Creset %s%C(red bold)%d%Creset\" --graph --date=relative"
alias gtrust="mkdir .git/safe"

# rails
alias r="rails"
alias rt="bundle exec rails test"
alias b="bundle"
alias be="bundle exec"
alias rs="bundle exec rails server"
alias rc="bundle exec rails console"
alias bi="bundle install"
alias bu="bundle update"
alias rdm="bundle exec rails db:migrate"
alias rdr="bundle exec rails db:drop db:create db:migrate"
alias spec="bundle exec rspec"

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
alias ccat="pygmentize -g -O style='colorful'" # colored cat
alias e="echo"
alias c="cd .."
alias psqlc="psql -U postgres"
alias todo="$EDITOR $TODO"
alias todol="$EDITOR todo.yml" # local todo
alias v=$EDITOR
alias search="find . -name" # search file by name
alias k9="kill -9"
alias now="date '+ %H:%M | %B %d'" # show current date and time
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
  alias init="sudo halt"
fi

# dotfiles quick access
alias cdd="cd ~/dotfiles"
alias profile="$EDITOR ~/dotfiles/shell/.profile"
alias bashrc="$EDITOR ~/dotfiles/shell/.bashrc"
alias zprofile="$EDITOR ~/dotfiles/shell/.zprofile"
alias zshrc="$EDITOR ~/dotfiles/shell/.zshrc"
alias aliases="$EDITOR ~/dotfiles/shell/aliases.sh"
alias functions="$EDITOR ~/dotfiles/shell/functions.sh"
alias environment="$EDITOR ~/dotfiles/shell/environment.sh"
alias envs="$EDITOR ~/dotfiles/shell/environment.sh"
alias temp-settings="$EDITOR ~/dotfiles/shell/temp_settings.sh"
alias temps="$EDITOR ~/dotfiles/shell/temp_settings.sh"
alias gitconfig="$EDITOR ~/dotfiles/git/.gitconfig"
alias gitignore-global="$EDITOR ~/dotfiles/.gitignore_global"
alias vimrc="$EDITOR ~/dotfiles/vim/.vimrc"
alias plugins="$EDITOR ~/dotfiles/vim/plugins.vim"
alias tmux-conf="$EDITOR ~/dotfiles/.tmux.conf"
alias pryrc="$EDITOR ~/dotfiles/.pryrc"
alias default-ctags="$EDITOR ~/dotfiles/default.ctags"

# system files access
alias hosts="$EDITOR /etc/hosts"
alias pg_hba="" # TODO with version and system

# some russian equivalents for wrong keyboard layout
alias "с"="cd .."
alias "св"="cd"
alias "свз"="cdp"
alias "свв"="cdd"
alias "свс"="cd $PROJECTS/$CURRENT_PROJECT"
alias "пые"="gst"
alias "ы"="s"
alias "ещвщ"="todo"
alias "ещвщд"="todol"
alias "м"="v"
# some caps equivalents
alias "C"="c"
alias "CD"="cd"
alias "CDP"="cdp"
alias "CDD"="cdd"
alias "CDC"="cd $PROJECTS/$CURRENT_PROJECT"
alias "GST"="gst"
alias "S"="s"
alias "TODO"="todo"
alias "TODOL"="todol"
alias "V"="v"

# some handy grep aliases from default .bashrc
if [ -x /usr/bin/dircolors ]; then
  alias grep="`which grep` --color=auto"
  alias fgrep="`which fgrep` --color=auto"
  alias egrep="`which egrep` --color=auto"
fi

# ls
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias ls='ls --color=auto -h'
  alias la='ls -A'
  alias l1='la -1'
  alias ll='ls -alh --color=auto --group-directories-first'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias ls="gls --color -h --group-directories-first"
  alias la="ls -A"
  alias l1="la -1"
  alias ll="gls -alh --color --group-directories-first"
fi
alias l="la"
