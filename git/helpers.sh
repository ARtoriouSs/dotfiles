alias g="git"
alias ginit="git init"
alias gcl="git clone"
alias gb="git branch"
alias gca="git commit --amend"

alias gco="git checkout"
gcom() { git checkout $(default-branch) }

alias gr="git rebase"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias grs="git rebase --skip"
grm() { git rebase $(default-branch) }

alias gf="git fetch"
alias fetch="git fetch origin"
alias gd="git diff \":(exclude)*package-lock.json\""
alias gds="git diff --staged \":(exclude)*package-lock.json\""
alias gl="git log --pretty=format:\"%C(yellow bold)%h%Creset | %C(blue bold)%ad%Creset, %C(green bold)%an%Creset %s%C(red bold)%d%Creset\" --graph --date=relative"
alias gcp="git cherry-pick"
alias gtrust="mkdir .git/safe"

# custom colored `git status --short`
alias gst="status"
# for typos
alias gs="status" # block ghost script invocation when making typo, remove this if you need ghost script
alias "пые"="gst"
alias "GST"="gst"
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

# copy file path from git status via fzf
cgst() {
  git status --porcelain | awk '{ print $2 }' | fzf --reverse | clip
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

origin-reset() {
    echo "Type 'y' to reset branch to the origin state"
    read key
    if [ "$key" = "y" ]; then
      git reset --hard origin/$(current-branch)
    else
      echo "Aborted"
    fi
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
  git commit -q -m "$*"
  status
}

# commit with Jira ticket prefix from branch name (if exist)
gcmm() {
  story_number=$(current-branch | awk 'BEGIN { FS = "/" }; { print "[" $1 "]" }')

  if [[ $story_number =~ "^\[[A-Z]*-[0-9]{1,6}\]$" ]]; then
    commit "$story_number $*"
  else
    commit "$*"
  fi
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

# pull current branch from origin
pull() {
  git pull origin "$(current-branch)"
  status
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

unignore() {
  git update-index --no-assume-unchanged $@
}

alias ghpr="github-pr"
github-pr() {
  gh pr create --assignee @me $@
}

# take PR title from the first commit in a branch
alias ghprc="github-pr-commit"
github-pr-commit() {
  github-pr --title "$(first-commit)" $@
}

# current branch helper function
current-branch() {
  git branch --show-current
}

# get name of the first commit in a branch
first-commit() {
  git log $(default-branch)..$(current-branch) --oneline | tail -1 | cut -f 2- -d ' '
}

default-branch() {
 if test -f .git/safe/default_branch; then
   cat .git/safe/default_branch
 else
   echo master
 fi
}

default-branch-edit() {
  $VISUAL .git/safe/default_branch
}
