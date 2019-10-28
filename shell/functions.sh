# open with default application
o() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        [ -z "$1" ] && xdg-open . || xdg-open $@
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        [ -z "$1" ] && open . || open $@
    fi
}

# cd to $PROJECTS and farther
alias cdc="cdp $CURRENT_PROJECT"
alias cdt="cdp test"
cdp() {
    cd $PROJECTS/$1
}

# clean $PROJECTS/test directory
clear_test() {
    rm -rf $PROJECTS/test
    mkdir $PROJECTS/test
}

# copy ssh key from id_rsa
copy_ssh() {
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
redis_up() {
    if [ "$1" = "--docker" ] || [ "$1" = "-d" ]
    then
        docker run -d -p 6379:6379 redis
    else
        redis-server --daemonize yes
    fi
}

# kill redis whether in system process or in docker
kill_redis() {
    ps aux | grep redis-server | awk '{ print $2; exit }' | xargs kill -9
    docker ps | grep redis | awk '{ print $1 }' | xargs docker rm -f
}

# kill server on specified port (3000 by default)
kill_s() {
    [ -z "$1" ] && PORT=3000 || PORT=$1
    lsof -i tcp:$PORT | grep -v 'chrome' | awk 'FNR > 1 {print $2}' | xargs kill -9
}

# rollback rails migrations
rollback() {
    [ -z "$1" ] && STEP=1 || STEP=$1
    rake db:rollback STEP=$STEP
}

# colored git status without excess info
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
    status
}

# git stash pop given stash or last one if no args specified
pop() {
    git stash pop --quiet $@
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
        echo "Type 'yes' to reset working tree to $(git rev-parse --short HEAD)"
        read KEY
        if [ "$KEY" = "yes" ]; then
            git reset HEAD --hard
            rm -rf $(git status --porcelain)
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
}
