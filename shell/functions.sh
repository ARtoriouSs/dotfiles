# clean &PROJECTS/test directory
clean_test() {
    rm -rf $PROJECTS/test
    mkdir $PROJECTS/test
}

# copy ssh key from id_rsa
copy_ssh() {
    pbcopy < ~/.ssh/id_rsa.pub
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
gst() {
    git status --porcelain | awk '{
        split($0, chars, "")
        index_bit = chars[1]
        tree_bit = chars[2]
        green = "\033[92m"
        yellow = "\033[93m"
        red = "\033[91m"
        violet = "\033[95m"
        default = "\033[0m"

        if ($1 == "??")
            output = "  " violet index_bit tree_bit "  " $2 default
        else if ($1 == "!!")
            output = "  " index_bit tree_bit "  " $2
        else {
            output = "  " green index_bit

            if (tree_bit == "D")
                output = output red tree_bit default "  "
            else
                output = output yellow tree_bit default "  "

            if (index_bit != " ") {
                if (index_bit == "R")
                    output = output green $2 default " " $3 " " green $4 default
                else
                    output = output green $2 default
            } else {
                if (tree_bit == "R")
                    output = output yellow $2 default " " $3 " " yellow $4 default
                else if (tree_bit == "D")
                    output = output red $2 default
                else
                    output = output yellow $2 default
            }
        }

        print output
    }'
}

# commit and quote all args as message
gcm() {
    git commit -v -m "$*"
}

# push current branch to origin
push() {
    CURRENT=$(git branch | grep '\*' | awk '{print $2}')
    git push origin "${CURRENT}"
}

# forse-push current branch to origin
forsepush() {
    CURRENT=$(git branch | grep '\*' | awk '{print $2}')
    git push -f origin "${CURRENT}"
}

# pull current branch from origin
pull() {
    CURRENT=$(git branch | grep '\*' | awk '{print $2}')
    git pull origin "${CURRENT}"
}

# reset git index and remove all created files
clean_git_index() {
    git reset HEAD --hard
    rm -rf $(git status --porcelain)
}
