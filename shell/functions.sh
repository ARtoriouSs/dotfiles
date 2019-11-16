# open with default application
o() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        [ -z "$1" ] && xdg-open . || xdg-open $@
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        [ -z "$1" ] && open . || open $@
    fi
}

# display linux 256 colors
color-list() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i
        if ! (( ($i + 1 ) % 8 )); then
            echo
        fi
    done
}

# cd to $PROJECTS and farther
alias cdc="cdp $CURRENT_PROJECT"
alias cdt="cdp test"
cdp() {
    cd $PROJECTS/$1
}

# clean $PROJECTS/test directory
clear-test() {
    rm -rf $PROJECTS/test
    mkdir $PROJECTS/test
}

# copy ssh key from id_rsa
copy-ssh() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        xclip -sel clip < ~/.ssh/id_rsa.pub
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        pbcopy < ~/.ssh/id_rsa.pub
    fi
}

# remove all docker containers
drmall() {
    docker rm -f $(docker ps -aq)
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
kill-redis() {
    ps aux | grep redis-server | awk '{ print $2; exit }' | xargs kill -9
    docker ps | grep redis | awk '{ print $1 }' | xargs docker rm -f
}

# kill server on specified port (3000 by default)
kill-s() {
    [ -z "$1" ] && PORT=3000 || PORT=$1
    lsof -i tcp:$PORT | grep -v 'chrome' | awk 'FNR > 1 {print $2}' | xargs kill -9
}

# generate rails migration and quote all args as name
alias migr="gen-migration"
gen-migration() {
    local IFS='_'
    bundle exec rails generate migration "$*"
}

# rollback rails migrations
rollback() {
    [ -z "$1" ] && STEP=1 || STEP=$1
    bundle exec rails db:rollback STEP=$STEP
}

# git status function with interactive option for running in separate tmux tab
alias gst="status"
status() {
    local PROJECT=$(basename $PWD)
    local LOCKFILE=~/git_status_interactive_for_$PROJECT.lock
    if [ "$1" = "--interactive" ] || [ "$1" = "-i" ]; then
        trap "rm -f $LOCKFILE" SIGINT
        touch $LOCKFILE
        while sleep 0.5s; do
            DIFF=$(diff $LOCKFILE <(colored_status))
            if [[ "$DIFF" != "" || $DIFF != "1do/n<" ]]; then
                clear
                printf "git status for $(tput setaf 208)$PROJECT$(tput sgr0):\n"
                colored_status
                echo "$(colored_status)" > $LOCKFILE
            fi
        done
    else
        colored_status
    fi
}

# colored_status that will not display status if interactive status lockfile exists for current pwd (for funcitons)
locked_status() {
    if [ ! -f ~/git_status_interactive_for_$(basename $PWD).lock ]; then
        colored_status
    fi
}

# colored `git status --short`
colored_status() {
    git status --porcelain | awk '{
        split($0, chars, "")
        index_bit = chars[1]
        tree_bit = chars[2]
        green = "\033[92m"
        yellow = "\033[93m"
        red = "\033[91m"
        violet = "\033[95m"
        white = "\033[0m"

        if ($1 == "??")
            output = "  " violet index_bit tree_bit "  " $2 white
        else if ($1 == "!!")
            output = "  " index_bit tree_bit "  " $2
        else if ((index_bit == "U" || tree_bit == "U") || (index_bit == "A" && tree_bit == "A") || (index_bit == "D" && tree_bit == "D"))
            output = "  " red index_bit tree_bit "  " $2 white
        else {
            output = "  " green index_bit

            if (tree_bit == "D")
                output = output red tree_bit white "  "
            else
                output = output yellow tree_bit white "  "

            if (index_bit != " ") {
                if (index_bit == "R")
                    output = output green $2 white " " $3 " " green $4 white
                else
                    output = output green $2 white
            } else {
                if (tree_bit == "R")
                    output = output yellow $2 white " " $3 " " yellow $4 white
                else if (tree_bit == "D")
                    output = output red $2 white
                else
                    output = output yellow $2 white
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
    locked_status
}

# git stash pop given stash or last one if no args specified
pop() {
    git stash pop --quiet $@
    locked_status
}

# git add files or all files if no args specified
alias ga="add"
add() {
    if [ -z "$1" ]; then
        git add --all
    else
        git add "$@"
    fi
    locked_status
}

# git reset file or all files if no args specified
reset() {
    if [ -z "$1" ]; then
        echo "Type 'y' to reset working tree to $(git rev-parse --short HEAD)"
        read KEY
        if [ "$KEY" = "y" ]; then
            git reset HEAD --hard
            rm -rf $(git status --short)
        else
            echo "aborted"
        fi
    else
        git checkout -- $@ &> /dev/null

        # check if there is untracked files in args and remove them
        UNTRACKED="$(git ls-files . --exclude-standard --others)"
        for RECORD in $(echo $UNTRACKED); do
            for ARG in "$@"; do
                if [ "$ARG" = "$RECORD" ]; then
                    rm -rf $RECORD
                fi
            done
        done
    fi
    locked_status
}

# remove file from index or all files if no args specified
alias grh="index"
index() {
    git reset -q HEAD $@
    locked_status
}

# commit and quote all args as message
alias gcm="commit"
commit() {
    git commit -v -m "$*"
    locked_status
}

alias gcan="amend-no-edit"
amend-no-edit() {
    git commit --amend --no-edit
    locked_status
}

# push current branch to origin
alias forsepush="push --force-with-lease"
alias fpush="push --force-with-lease"
push() {
    CURRENT=$(git branch | grep '\*' | awk '{print $2}')
    git push $@ origin "${CURRENT}"
}

# pull current branch from origin
pull() {
    CURRENT=$(git branch | grep '\*' | awk '{print $2}')
    git pull origin "${CURRENT}"
    locked_status
}

# clone repo from github
alias get="clone-my"
clone-my() {
    git clone git://github.com/$GITHUB_USERNAME/$1.git $2
}
