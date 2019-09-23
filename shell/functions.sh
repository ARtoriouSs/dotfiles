# run redis in docker in a background
redis_up() {
    docker run -d -p 6379:6379 redis
}

# kill server on specified port (3000 by default)
kill_rs() {
    [ -z "$1" ] && PORT=3000 || PORT=$1
    lsof -i tcp:$PORT | grep -v 'chrome' | awk 'FNR > 1 {print $2}' | xargs kill -9
}

# rollback rails migrations
rollback() {
    [ -z "$1" ] && STEP=1 || STEP=$1
    rake db:rollback STEP=$STEP
}

# git status without excess info
gst() {
    git status --porcelain | awk '{
        if ($1 == "M")
            print "  ", "\033[93m"$2"\033[0m"
        else if ($1 == "D")
            print "  ", "\033[91m"$2"\033[0m"
        else if ($1 == "A")
            print "  ", "\033[92m"$2"\033[0m"
        else if ($1 == "??")
            print "  ", "\033[95m"$2"\033[0m"
        else
            print $1, $2
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
