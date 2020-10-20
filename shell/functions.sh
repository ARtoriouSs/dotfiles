# open with default application
o() {
  if [[ "$OSTYPE" == "linux-gnu" ]]; then
    [ -z "$1" ] && xdg-open . || xdg-open $@
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    [ -z "$1" ] && open . || open $@
  fi
}

# open tmux session for rails project, takes path as an argument, $PWD by default
alias tp="t-project"
alias tc="t-project $PROJECTS/$CURRENT_PROJECT" # project session for the current project
t-project() {
  if [ -z "$1" ]; then
    local session_name=$(basename $PWD)
    local project_path=$PWD
  else
    local session_name=$(basename $1)
    local project_path=$1
  fi

  if [ ! -d $project_path ]; then
    echo "$(tput setaf 208)$project_path$(tput sgr0) doesn't exist"
    return 1
  fi

  tmux has-session -t "$session_name"
  if [ $? != 0 ]; then
    tmux new-session -d -s "$session_name" -n "$session_name" -c $project_path $VISUAL

    tmux split-window -v -c $project_path
    tmux resize-pane -D 20

    tmux send-keys -t "$session_name:0.1" "rc" Enter
    tmux select-pane -t 0
  fi
  tmux -2 attach-session -t "$session_name"
}

# open tmux default session, takes path as an argument, $PWD by default
alias td="t-default"
t-default() {
  if [ -z "$1" ]; then
    local session_name=$(basename $PWD)
    local project_path=$PWD
  else
    local session_name=$(basename $1)
    local project_path=$1
  fi

  if [ ! -d $project_path ]; then
    echo "$(tput setaf 208)$project_path$(tput sgr0) doesn't exist"
    return 1
  fi

  tmux has-session -t "$session_name"
  if [ $? != 0 ]; then
    tmux new-session -d -s "$session_name" -n "$session_name" -c "$project_path"
    tmux split-window -h

    tmux next-window -t "$session_name"
    tmux select-pane -t 0

    tmux send-keys -t "${session_name}:0.0" "cowsay Hello!" Enter
    tmux send-keys -t "${session_name}:0.1" "status" Enter
  fi
  tmux -2 attach-session -t "$session_name"
}

# kill tmux session for current directory
alias tk="t-kill"
alias tka="t-kill --all" # kill all tmux sessions along with a server
t-kill() {
  if [ "$1" = "--all" ]; then
    tmux kill-server
  else
    local session_name=$([ -z "$1" ] && echo $(basename $PWD) || echo $1)
    tmux has-session -t "$session_name"
    [ $? = 0 ] && tmux kill-session -t "$session_name"
  fi
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
  if [[ "$OSTYPE" == "darwin"* ]]; then
    rm /usr/local/var/postgres/postmaster.pid
    brew services restart postgres
  elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo service postgresql restart
  fi
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
  if [[ "$OSTYPE" == "darwin"* ]]; then
    pbcopy < $@
  elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    xclip -sel clip < $@
  fi
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

# generate rails migration and quote all args as name
alias migr="gen-migration"
gen-migration() {
  local IFS='_'
  bundle exec rails generate migration "$*"
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

# colored `git status --short`
alias gs="status" # block ghost script invocation when making typo, remove this if you need ghost script
alias gst="status"
status() {
  git status --porcelain | awk '{
    split($0, chars, "")
    index_bit = chars[1]
    tree_bit = chars[2]
    green = "\033[92m"
    yellow = "\033[93m"
    red = "\033[91m"
    violet = "\033[95m"
    white = "\033[0m"
    $1=""

    if (index_bit == "?" && tree_bit == "?")
        output = "  " violet index_bit tree_bit "  " $0 white
    else if (index_bit == "!" && tree_bit == "!")
        output = "  " index_bit tree_bit "  " $0
    else if ((index_bit == "U" || tree_bit == "U") || (index_bit == "A" && tree_bit == "A") || (index_bit == "D" && tree_bit == "D"))
        output = "  " red index_bit tree_bit "  " $0 white
    else {
        output = "  " green index_bit

        if (tree_bit == "D")
            output = output red tree_bit white "  "
        else
            output = output yellow tree_bit white "  "

        if (index_bit != " ") {
            output = output green $0 white
        } else {
            if (tree_bit == "D")
                output = output red $0 white
            else
                output = output yellow $0 white
        }
    }

    print output
  }'
}

# git stash file or all files if no args specified
stash() {
  if [ -z "$1" ]; then
    git stash
  else
    git stash push "$@"
  fi
  status
}

# git stash pop given stash or last one if no args specified
pop() {
  git stash pop $@
  status
}

# git add files or all files if no args specified
alias ga="add"
add() {
  if [ -z "$1" ]; then
    git add --all
  else
    git add "$@"
  fi
  status
}

# git reset file or all files if no args specified
reset() {
  if [ -z "$1" ]; then
    echo "Type 'y' to reset working tree to $(git rev-parse --short HEAD)"
    read key
    if [ "$key" = "y" ]; then
      git reset HEAD --hard
      rm -rf $(git status --short)
    else
      echo "Aborted"
    fi
  else
    git checkout -- $@ &> /dev/null

    # check if there is untracked files in args and remove them
    local untracked="$(git ls-files . --exclude-standard --others)"
    for record in $(echo $untracked); do
      for arg in "$@"; do
        if [ "$arg" = "$record" ]; then
          rm -rf $record
        fi
      done
    done
  fi
  status
}
# reset without confirmation
freset() {
  if [ -z "$1" ]; then
    git reset HEAD --hard
    rm -rf $(git status --short)
  else
    git checkout -- $@ &> /dev/null

    # check if there is untracked files in args and remove them
    local untracked="$(git ls-files . --exclude-standard --others)"
    for record in $(echo $untracked); do
      for arg in "$@"; do
        if [ "$arg" = "$record" ]; then
          rm -rf $record
        fi
      done
    done
  fi
  status
}

# remove file from index or all files if no args specified
alias grh="index"
index() {
  git reset -q HEAD $@
  status
}

# commit and quote all args as message
alias gcm="commit"
commit() {
  git commit -v -m "$*"
  status
}

alias gcan="amend-no-edit"
amend-no-edit() {
  git commit --amend --no-edit
  status
}

# push current branch to origin
alias forsepush="push --force-with-lease"
alias fpush="push --force-with-lease"
push() {
  git push $@ origin "$(current-branch)"
  status
}
push-my() { # same as above but to 'my' remote
  git push $@ my "$(current-branch)"
  status
}

# pull current branch from origin
pull() {
  git pull origin "$(current-branch)"
  status
}

# current branch helper function
current-branch() {
  git branch --show-current
}

grem() {
  if [ -z "$1" ]; then
    git remote -v
  else
    git remote "$@"
    git remote -v
  fi
}

# clone repo from github
alias get="clone-my"
clone-my() {
  git clone git@github.com:$GITHUB_USERNAME/$1.git $2
}

# ignore without .gitignore
ignore() {
  git update-index --assume-unchanged $@
}

no-ignore() {
  git update-index --no-assume-unchanged $@
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
