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
    tmux new-session -d -s "$session_name" -n "$session_name" -c $project_path $VISUAL todo.yml

    tmux split-window -v -c $project_path
    tmux resize-pane -D 20
  fi
  tmux -2 attach-session -t "$session_name"
}

# runs a command in the pane #0 of the tmux session for the current directory (usually an editor)
run-in-editor() {
  local session_name=$(basename $PWD)

  tmux has-session -t "$session_name"
  if [ $? = 0 ]; then
    tmux send-keys -t "${session_name}:0.0" "$@" Enter
  fi
}

# runs a command in the pane #1 of the tmux session for the current directory
run-beside() {
  local session_name=$(basename $PWD)

  tmux has-session -t "$session_name"
  if [ $? = 0 ]; then
    tmux send-keys -t "${session_name}:0.1" C-c
    tmux send-keys -t "${session_name}:0.1" "$@" Enter
  fi
}

tmux-edit-file() {
  run-in-editor ":edit $1"
}

# choose a file from git status and edit it in the editor pane
egst() {
  local file
  file=$(git status --porcelain | awk '{ print $2 }' | fzf --reverse) || return
  tmux-edit-file "$file"
}

# runs the last command in the pane #1, to be used in vim command
last-command-beside() {
  run-beside C-p
}

# shows git status in the pane #1, to be used in vim command
status-beside() {
  run-beside status
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

alias t-detach="tmux detach"
