#!/bin/bash

source ~/dotfiles/shell/environment.sh

if [ -z "$TODO" ]
then
    export TODO=~/todo/todo.yml
fi

git --git-dir=$(dirname $TODO)/.git --work-tree=$(dirname $TODO) pull --no-edit origin master
git --git-dir=$(dirname $TODO)/.git --work-tree=$(dirname $TODO) add $TODO
git --git-dir=$(dirname $TODO)/.git --work-tree=$(dirname $TODO) commit --amend --no-edit
git --git-dir=$(dirname $TODO)/.git --work-tree=$(dirname $TODO) push -f origin master &> ~/lel
