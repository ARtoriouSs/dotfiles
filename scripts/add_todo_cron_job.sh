# create repo and gitignore
if [ -z "$TODO" ]
then
    export TODO=~/todo/todo.yml
fi

cd $(basename $TODO)
git init
git commit --allow-empty -m "sync"

# add remote
if [ -z "$TODO_REMOTE_URL" ]
then
    echo "\$TODO_REMOTE_URL must be set. It should use ssh protocol."
    echo "Please create private repo and run TODO_REMOTE_URL=<url> ./add_todo_cron_job.sh"
    rm -rf .git
    exit 1
else
    git remote add origin $TODO_REMOTE_URL
fi

# add cron job for pushing
crontab -l | { cat; echo "* * * * * ~/dotfiles/scripts/sync_todo.sh"; } | crontab -
