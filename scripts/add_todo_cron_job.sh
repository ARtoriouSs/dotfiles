# create repo and gitignore
if [ -z "$TODO" ]
then
    export TODO=~/todo.yml
fi

cd $HOME
git init
touch .gitignore
echo "/*" >> .gitignore
echo "!$(basename $TODO)" >> .gitignore

# add remote
if [ -z "$TODO_REMOTE_URL" ]
then
    echo "\$TODO_REMOTE_URL must be set. It should use ssh protocol."
    echo "Please create private repo and run TODO_REMOTE_URL=<url> ./add_todo_cron_job.sh"
    rm -rf .gitignore .git
    exit 1
else
    git remote add origin $TODO_REMOTE_URL
fi

# add cron job for pushing
crontab -l | { cat; echo "* * * * * ~/my_folder/projects/test/test.sh"; } | crontab -

# add init.d script for changes listening
