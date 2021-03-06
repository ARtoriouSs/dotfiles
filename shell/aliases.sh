# git
alias g="git"
alias ginit="git init"
alias gcl="git clone"
alias gb="git branch"
alias gco="git checkout"
alias gcom="git checkout master"
alias gca="git commit --amend"
alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias grm="git rebase master"
alias gm="git merge"
alias gma="git merge --abort"
alias gmc="git merge --continue"
alias gf="git fetch"
alias fetch="git fetch origin"
alias gd="git diff \":(exclude)*package-lock.json\""
alias gl="git log --pretty=format:\"%C(yellow bold)%h%Creset | %C(blue bold)%ad%Creset, %C(green bold)%an%Creset %s%C(red bold)%d%Creset\" --graph --date=relative"
alias gtrust="mkdir .git/safe"

# rails
alias r="rails"
alias b="bundle"
alias be="bundle exec"
alias rs="bundle exec rails server"
alias rc="bundle exec rails console"
alias bi="bundle install"
alias bu="bundle update"
alias rdm="bundle exec rails db:migrate"
alias rdr="bundle exec rails db:drop db:create db:migrate"
alias spec="bundle exec rspec"

# phoenix
alias mixer="iex --erl \"-kernel shell_history enabled\" -S mix phx.server"
alias m="mix"
alias mi="mix deps.get"
alias mem="mix ecto.migrate"
alias mer="mix do ecto.drop, ecto.create, ecto.migrate"
alias mt="mix test"
alias espec="mix espec"

# npm
alias nr="npm run"
alias ni="npm install"
alias ns="npm run start"
alias nt="npm run test"
alias nd="npm run debug"

# yarn
alias y="yarn"
alias yi="yarn install"
alias yt="yarn test"

# docker
alias d="docker"
alias dr="docker run"
alias dps="docker ps -a"
alias di="docker images -a"
alias drm="docker rm -f"
alias drmi="docker rmi -f"
alias dcp="docker-compose"
alias dcps="docker-compose ps -a"

# system
alias ccat="pygmentize -g -O style='colorful'" # colored cat
alias e="echo"
alias c="cd .."
alias psqlc="psql -U postgres"
alias todo="$VISUAL $TODO"
alias todol="$VISUAL todo.yml" # local todo
alias v=$VISUAL
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
alias profile="$VISUAL ~/dotfiles/shell/.profile"
alias bashrc="$VISUAL ~/dotfiles/shell/.bashrc"
alias zprofile="$VISUAL ~/dotfiles/shell/.zprofile"
alias zshrc="$VISUAL ~/dotfiles/shell/.zshrc"
alias aliases="$VISUAL ~/dotfiles/shell/aliases.sh"
alias functions="$VISUAL ~/dotfiles/shell/functions.sh"
alias environment="$VISUAL ~/dotfiles/shell/environment.sh"
alias envs="$VISUAL ~/dotfiles/shell/environment.sh"
alias temp-settings="$VISUAL ~/dotfiles/shell/temp_settings.sh"
alias temps="$VISUAL ~/dotfiles/shell/temp_settings.sh"
alias gitconfig="$VISUAL ~/dotfiles/git/.gitconfig"
alias gitignore-global="$VISUAL ~/dotfiles/.gitignore_global"
alias vimrc="$VISUAL ~/dotfiles/vim/.vimrc"
alias plugins="$VISUAL ~/dotfiles/vim/plugins.vim"
alias tmux-conf="$VISUAL ~/dotfiles/.tmux.conf"
alias pryrc="$VISUAL ~/dotfiles/.pryrc"
alias default-ctags="$VISUAL ~/dotfiles/default.ctags"

# system files access
alias hosts="$VISUAL /etc/hosts"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias pg-hba="sudo $VISUAL -p /etc/postgresql/*/main/pg_hba.conf"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias pg-hba="sudo $VISUAL -p /usr/local/var/postgres/pg_hba.conf"
fi

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
