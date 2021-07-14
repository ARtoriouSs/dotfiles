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
