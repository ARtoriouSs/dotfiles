#!/bin/bash

if [ -z "$TODO" ]; then
    export TODO=~/todo/todo.yml
fi

# create repo
if ! test -f $TODO; then
    echo "\$TODO must refer to an existing file"
    exit 1
fi

if [ -z "$TODO_REMOTE_URL" ]; then
    echo "\$TODO_REMOTE_URL must be set. It should use ssh protocol."
    echo "Please create private repo and run TODO_REMOTE_URL=<url> ./add_todo_cron_job.sh"
    exit 1
fi

cd $(dirname $TODO)
touch .gitignore
echo "!$(basename $TODO)" >> .gitignore # forse not to ignore todo file
git init
git add .gitignore
git commit -m "Add .gitignore"
git add $(basename $TODO)
git commit -m "Synchronize"
git remote add origin $TODO_REMOTE_URL
git push origin master

# add cron job for syncing
crontab -l | { cat; echo "* * * * * ~/dotfiles/scripts/sync_todo.sh"; } | crontab -
