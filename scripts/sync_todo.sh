#!/bin/bash

source ~/dotfiles/shell/environment.sh

if [ -z "$TODO" ]
then
    export TODO=~/todo/todo.yml
fi

# git --git-dir=$(dirname $TODO)/.git --work-tree=$(dirname $TODO) pull origin master &> ~/lel
git --git-dir=$(dirname $TODO)/.git --work-tree=$(dirname $TODO) add $TODO
# git --git-dir=$(dirname $TODO)/.git --work-tree=$(dirname $TODO) commit --amend --no-edit &> ~/lel
# git --git-dir=$(dirname $TODO)/.git --work-tree=$(dirname $TODO) push -f origin master &> ~/lel
