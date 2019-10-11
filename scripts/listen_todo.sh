# install fswatch if not installed
if ! type fswatch > /dev/null; then
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        apt-get update
        apt-get install fswatch
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install fswatch
    fi
fi

# listen to changes in todo file and make commits
if [ -z "$TODO" ]
then
    export TODO=~/todo.yml
fi

fswatch $TODO | while read;
do
    git --git-dir ~/.git add $TODO
    git --git-dir ~/.git commit --amend --no-edit
done
