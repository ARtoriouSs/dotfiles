source ~/dotfiles/shell/environment.sh

if [ -z "$TODO" ]
then
    export TODO=~/todo.yml
fi

git --git-dir $(dirname $TODO)/.git add $(realpath --relative-to=. $TODO) &> ~/lel
git --git-dir $(dirname $TODO)/.git commit --amend --no-edit &> ~/lel
git --git-dir $(dirname $TODO)/.git push -f origin master &> ~/lel
