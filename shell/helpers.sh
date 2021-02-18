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
alias upd="sudo apt-get --yes update"
alias upg="sudo apt-get --yes upgrade"
alias install="sudo apt-get --yes update && sudo apt-get --yes install"
alias i="sudo apt-get --yes install"

alias susp="systemctl suspend"
alias shut="init 0"
alias halt="init 0"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
alias hosts="sudoedit /etc/hosts"
alias pg-hba="sudoedit /etc/postgresql/*/main/pg_hba.conf"

# some russian equivalents for wrong keyboard layout
alias "с"="cd .."
alias "св"="cd"

# some caps equivalents
alias "C"="c"
alias "CD"="cd"

# handy grep aliases from default .bashrc
if [ -x /usr/bin/dircolors ]; then
  alias grep="`which grep` --color=auto"
  alias fgrep="`which fgrep` --color=auto"
  alias egrep="`which egrep` --color=auto"
fi

# ls
alias ls='ls --color=auto -h'
alias la='ls -A'
alias l="la"
alias ll='ls -alh --color=auto --group-directories-first'

# open with default application
o() {
  [ -z "$1" ] && xdg-open . || xdg-open $@
}

# generate ctags
tags() {
  local git_dir=$(git --no-optional-locks rev-parse --git-dir)
  trap 'rm -f "$git_dir/$$.tags"' EXIT

  case "$1" in
    --rails) # add gems paths and cut off bundler warnings with awk
      ctags -f $git_dir/$$.tags . $(bundle list --paths | awk '/^\// { print $0 }')
    ;;
    --elixir)
      ctags --exclude=_build -f $git_dir/$$.tags .
    ;;
    --js)
      ctags --exclude=tmp -f $git_dir/$$.tags .
    ;;
    *)
      ctags -f $git_dir/$$.tags .
    ;;
  esac

  mv "$git_dir/$$.tags" "$git_dir/tags"
}

alias psqlr="restart-postgres"
restart-postgres() {
  sudo service postgresql restart
}

# display linux 256 colors
color-list() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i
    if ! (( ($i + 1) % 8 )); then
      echo
    fi
  done
}

# cd to $PROJECTS and farther
alias cdcc="cdp $CURRENT_PROJECT/.." # if project is in subdirectory
alias cdc="cdp $CURRENT_PROJECT"
alias cdt="cdp test"
cdp() {
  cd $PROJECTS/$1
}

# clean $PROJECTS/test directory
clear-test() {
  rm -rf $PROJECTS/test
  mkdir $PROJECTS/test
  cd $PROJECTS/test
  git init > /dev/null
  cd - > /dev/null
}

# copy to system clipboard
clip() {
  xclip -rmlastnl -selection clipboard
}

# remove all docker containers and images
dclean() {
  docker system prune -f
  docker rm -f $(docker ps -aq)
  docker rmi -f $(docker images -aq)
}

# run redis in docker in a background
redis-up() {
  if [ "$1" = "--docker" ] || [ "$1" = "-d" ]
  then
    docker run -d -p 6379:6379 redis
  else
    redis-server --daemonize yes
  fi
}

# kill redis whether in system process or in docker
redis-down() {
  ps aux | grep redis-server | awk '{ print $2; exit }' | xargs kill -9
  docker ps | grep redis | awk '{ print $1 }' | xargs docker rm -f
}

# kill server on specified port (3000 by default)
alias ks="kill-server"
kill-server() {
  [ -z "$1" ] && local port=3000 || local port=$1
  lsof -i tcp:$port | grep -v 'chrome\|insomnia' | awk 'FNR > 1 {print $2}' | xargs kill -9
}

# generate rails migration, quote all args as name and copy path to the clipboard
alias migr="gen-migration"
gen-migration() {
  local IFS='_'
  output=$(bundle exec rails generate migration "$*")
  echo $output | grep create | awk '{ print $2 }' | clip

  echo $output
}

# rollback rails migrations
rollback() {
  [ -z "$1" ] && local step=1 || local step=$1
  bundle exec rails db:rollback STEP=$step
}

alias rr="search-routes"
search-routes() {
  if [ -z "$1" ]; then
    bundle exec rails routes
  else
    bundle exec rails routes | $GREP_TOOL $@
  fi
}

# grep Gemfile in current project directory
alias gems="search-gems"
search-gems() {
  local location_backup=$PWD
  while [ $PWD != $HOME ] && [ $PWD != "/" ]; do
    if test -f "Gemfile"; then
      cat Gemfile | $GREP_TOOL $@
      return
    else
      cd ..
    fi
  done
  echo "No Gemfile found. Are you inside rails project?"
  cd $location_backup
}

# show weather
wttr() {
  local url="wttr.in?FMp"

  case "$1" in
    1) url+='1' ;;
    2) url+='2' ;;
    3) ;;
    *) url+='0' ;;
  esac

  curl $url
}
