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

alias psqlr="restart-postgres"
restart-postgres() {
  sudo service postgresql restart
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
