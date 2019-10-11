if ! type fswatch > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        apt-get update
        apt-get install fswatch
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install fswatch
    fi
fi

# init repo if not
# maybe todo to directory
# path in cron

fswatch $TODO | while read;
do
    git add $TODO
    git commit --amend --no-edit
done
