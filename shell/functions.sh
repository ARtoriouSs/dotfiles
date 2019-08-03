# run redis in a background
redis_up() {
    docker run -d -p 6379:6379 redis
}

# rollback rails migrations
rollback() {
    [ -z "$1" ] && STEP=1 || STEP=$1
    rake db:rollback STEP=$STEP
}

# commit and quote all args as message
gcm() {
    git commit -v -m "$*"
}

# kill rails server
kill_rs() {
    lsof -i tcp:3000 | grep -v 'chrome' | awk 'FNR > 1 {print $2}' | xargs kill -9
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

# push current branch to heroku master
heroku_push() {
    CURRENT=$(git branch | grep '\*' | awk '{print $2}')
    git push heroku "${CURRENT}":master
}

# forse-push current branch to origin
heroku_forsepush() {
    CURRENT=$(git branch | grep '\*' | awk '{print $2}')
    git push -f heroku "${CURRENT}":master
}

# pull current branch from origin
pull() {
    CURRENT=$(git branch | grep '\*' | awk '{print $2}')
    git pull origin "${CURRENT}"
}

# pull master and rebase current branch on it
rebase() {
  CURRENT=$(git branch | grep '\*' | awk '{print $2}')
  git checkout master
  git pull origin master
  git checkout "${CURRENT}"
  git rebase master
}

# reset git index and remove all created files
clean_git_index() {
    git reset HEAD --hard
    rm -rf $(git status --porcelain)
}
