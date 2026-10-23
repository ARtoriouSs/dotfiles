# open tmux session for rails project, takes path as an argument, $PWD by default
alias tp="t-project"
alias tc='t-project $PROJECTS/$CURRENT_PROJECT' # project session for the current project
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

  tmux has-session -t "=$session_name"
  if [ $? != 0 ]; then
    tmux new-session -d -s "$session_name" -n "$session_name" -c $project_path $VISUAL todo.yml

    tmux split-window -v -c $project_path
    tmux resize-pane -D 20

    # claude beside the bottom shell, typed into a shell so the pane survives claude exit
    tmux split-window -h -c $project_path
    tmux send-keys "claude" Enter
    tmux select-pane -L
  fi
  tmux -2 attach-session -t "=$session_name"
}

# prints id of the n-th (from 0) pane in the first window of the current tmux session,
# or of the session for the current directory when called outside of tmux;
# workmux sidebar panes are skipped, so numbering is the same with and without the sidebar
t-pane() {
  if [ -n "$TMUX" ]; then
    local session_name=$(tmux display-message -p -t "$TMUX_PANE" '#S')
  else
    local session_name=$(basename $PWD)
    tmux has-session -t "=$session_name" 2> /dev/null || return 1
  fi

  tmux list-panes -t "=${session_name}:0" -F '#{pane_id} #{@workmux_role}' |
    awk -v n="$1" '$2 == "" && i++ == n { print $1 }'
}

# runs a command in the pane #0 of the tmux session for the current directory (usually an editor)
run-in-editor() {
  local pane=$(t-pane 0)

  if [ -n "$pane" ]; then
    tmux send-keys -t "$pane" "$@" Enter
  fi
}

# runs a command in the pane #1 of the tmux session for the current directory
run-beside() {
  local pane=$(t-pane 1)

  if [ -n "$pane" ]; then
    tmux send-keys -t "$pane" C-c
    tmux send-keys -t "$pane" "$@" Enter
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

  tmux has-session -t "=$session_name"
  if [ $? != 0 ]; then
    tmux new-session -d -s "$session_name" -n "$session_name" -c "$project_path"
    tmux split-window -h

    tmux next-window -t "=$session_name"
    tmux select-pane -t 0

    tmux send-keys -t "=${session_name}:0.0" "cowsay Hello!" Enter
    tmux send-keys -t "=${session_name}:0.1" "status" Enter
  fi
  tmux -2 attach-session -t "=$session_name"
}

# kill tmux session for current directory
alias tk="t-kill"
alias tka="t-kill --all" # kill all tmux sessions along with a server
t-kill() {
  if [ "$1" = "--all" ]; then
    tmux kill-server
  else
    local session_name=$([ -z "$1" ] && echo $(basename $PWD) || echo $1)
    tmux has-session -t "=$session_name"
    [ $? = 0 ] && tmux kill-session -t "=$session_name"
  fi
}

alias t-detach="tmux detach"

alias wm="workmux"
alias wo="workmux open"
alias wa="workmux add"
# copy/symlink files again, plus .env* files from monorepo subfolders
alias ws="workmux sync-files && ~/dotfiles/tmux/workmux/link-env.sh"

# open the current repo or worktree in a separate tmux server managed by workmux,
# sessions are named and laid out like `tp` (see tmux/workmux/config.yaml),
# the default tmux server and its sessions are left untouched
alias wmx="t-workmux"
t-workmux() {
  local root=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -z "$root" ]; then
    echo "$(tput setaf 208)$PWD$(tput sgr0) is not a git repository"
    return 1
  fi
  if ! git rev-parse --verify --quiet HEAD > /dev/null; then
    echo "$(tput setaf 208)$root$(tput sgr0) has no commits yet, workmux needs at least one"
    return 1
  fi

  # workmux addresses the main checkout by its branch and worktrees by their directory
  local handle
  if [ "$(git rev-parse --path-format=absolute --git-common-dir)" = "$root/.git" ]; then
    handle=$(git branch --show-current)
  else
    handle=$(basename $root)
  fi

  # workmux opens panes in the directory of the nearest .workmux.yaml, falling back to
  # the repo root, so mark a monorepo subproject unless some config is already on the way up
  local dir=$(pwd -P)
  if [ "$dir" != "$root" ]; then
    while [ "$dir" != "$root" ] && [ ! -f "$dir/.workmux.yaml" ]; do dir=$(dirname "$dir"); done
    if [ ! -f "$dir/.workmux.yaml" ]; then
      echo "# workmux: open panes in this subproject (created by wmx)" > .workmux.yaml
    fi
  fi

  if [ -n "$TMUX" ]; then
    if [ "$(basename ${TMUX%%,*})" = "workmux" ]; then
      workmux open "$handle"
    else
      echo "already inside tmux, run $(tput setaf 208)wmx$(tput sgr0) from a plain terminal"
      return 1
    fi
  else
    # throwaway session: switches the client to the worktree session and kills itself,
    # sidebar panes would keep it alive otherwise; the sidebar daemon is started by the
    # tmux server (run-shell), so it doesn't die along with the throwaway pane.
    # started in $PWD, so workmux picks up the subproject .workmux.yaml
    tmux -L workmux new-session -c "$PWD" \
      "tmux run-shell -b 'workmux sidebar on'; workmux open '$handle' || read; tmux kill-session -t \$TMUX_PANE"
  fi
}
