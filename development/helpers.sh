# rails
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias rdm="bundle exec rails db:migrate"
alias rddm="bundle exec rails data:migrate"
alias fspec="bundle exec rspec --fail-fast"

# docker
alias dps="docker ps -a"
alias di="docker images -a"
alias drm="docker rm -f"
alias drmi="docker rmi -f"
alias dcp="docker-compose"
alias dcps="docker-compose ps -a"

# postman
alias postman="/opt/Postman/app/Postman"

# Postgres
alias psqlc="psql -U postgres"

# Avante CLI mode
alias avante='nvim -c "lua vim.defer_fn(function()require(\"avante.api\").zen_mode()end, 100)"'

# remove all docker containers and images
dclear() {
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

alias rs="server"
alias mixer="iex --erl \"-kernel shell_history enabled\" -S mix phx.server"
server() {
  case $(current-language) in
    "ruby/rails")
      bundle exec rails server $@
      ;;
    "ruby")
      source .env &> /dev/null
      ./bin/server $@
      ;;
    "elixir/phoenix")
      source .env &> /dev/null
      iex --erl \"-kernel shell_history enabled\" -S mix phx.server $@
      ;;
    "elixir")
      source .env &> /dev/null
      ./bin/server $@
      ;;
    *)
      bundle exec rails server $@
      ;;
  esac
}

migrate() {
  case $(current-language) in
    "ruby/rails")
      bundle exec rails db:migrate $@
      ;;
    "ruby/rails")
      bundle exec rake db:migrate $@
      ;;
    "elixir" | "elixir/phoenix")
      mix ecto.migrate $@
      ;;
    *)
      bundle exec rails db:migrate $@
      ;;
  esac
}

deps() {
  case $(current-language) in
    "ruby" | "ruby/rails")
      bundle install $@
      ;;
    "elixir" | "elixir/phoenix")
      mix deps.get $@
      ;;
    *)
      bundle install $@
      ;;
  esac
}

alias sopec="spec"
spec() {
  case $(current-language) in
    "ruby/rails")
      bundle exec rspec $@
      ;;
    "ruby")
      source .env &> /dev/null
      bundle exec rspec $@
      ;;
    "elixir/phoenix")
      source .env &> /dev/null
      iex -S mix test --timeout 600000 $@
      ;;
    "elixir")
      source .env &> /dev/null
      ./bin/test $@
      ;;
    *)
      bundle exec rspec $@
      ;;
  esac
}

alias rc="console"
console() {
  case $(current-language) in
    "ruby/rails")
      bundle exec rails console $@
      ;;
    "ruby")
      source .env &> /dev/null
      ./bin/console $@
      ;;
    "elixir" | "elixir/phoenix")
      source .env &> /dev/null
      iex -S mix $@
      ;;
    *)
      bundle exec rails console $@
      ;;
  esac
}

# generate rails migration, quote all args as name and copy path to the clipboard
alias migr="gen-migration"
gen-migration() {
  local IFS='_'
  output=$(bundle exec rails generate migration "$*")
  echo $output | grep create | awk '{ print $2 }' | clip

  echo $output
}

# generate data migration (https://github.com/ilyakatz/data-migrate),
# quote all args as name and copy path to the clipboard
alias d-migr="gen-data-migration"
gen-data-migration() {
  local IFS='_'
  output=$(bundle exec rails generate data_migration "$*")
  echo $output | grep create | awk '{ print $2 }' | clip

  echo $output
}

# rollback rails migrations
rollback() {
  [ -z "$1" ] && local step=1 || local step=$1

  case $(current-language) in
    "ruby/rails")
      bundle exec rails db:rollback STEP=$step
      ;;
    "ruby")
      bundle exec rake db:rollback STEP=$step
      ;;
    "elixir" | "elixir/phoenix")
      mix ecto.rollback --step $step
      ;;
    *)
      bundle exec rails db:rollback STEP=$step
      ;;
  esac
}

# rollback rails data migrations
d-rollback() {
  [ -z "$1" ] && local step=1 || local step=$1
  bundle exec rails data:rollback STEP=$step
}

# get last migration file name
last-migration() {
  local dir=$( [ -d db/migrate ] && echo db/migrate || echo db/migrations )
  ls -1 "$dir" | sort | tail -n 1 | awk -v d="$dir" '{print d "/" $0}'
}

# copy last migration file name to clipboard
alias clip-migr="copy-last-migration"
copy-last-migration() {
  last-migration | clip
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
  echo "No Gemfile found. Are you inside ruby project?"
  cd $location_backup
}

# update versions list
rbenv-update() {
  git -C ~/.rbenv/plugins/ruby-build pull
}

# run rubocop for all files changed in current branch
alias rcop="rubocop-changed"
rubocop-changed() {
  local modified_and_added=$(git --no-pager diff --diff-filter=d --name-only $(git merge-base $(default-branch) HEAD) | $GREP_TOOL "\.rb|\.ru|\.rack|Gemfile")
  local modified_and_added_absolute=$(echo $modified_and_added | sed "s|^|$(git-root)/|g")
  echo $modified_and_added_absolute| xargs --no-run-if-empty --verbose bundle exec rubocop --force-exclusion $@
}

# run rspec for all specs changed in current branch
alias spec-c="rspec-changed"
rspec-changed() {
  local modified_and_added_specs=$(git --no-pager diff --diff-filter=d --name-only $(git merge-base $(default-branch) HEAD) | $GREP_TOOL "_spec\.rb")

  if [ -z "$modified_and_added_specs" ]; then
    echo "No modified specs"
  else
    echo $modified_and_added_specs | xargs --verbose bundle exec rspec $@
  fi
}

current-language() {
  local file_path=".git/safe/current_language"

   if [[ ! -s "$file_path" ]]; then
     echo "ruby"
   else
     cat "$file_path"
   fi
}

current-language-edit() {
  $VISUAL .git/safe/current_language
}
