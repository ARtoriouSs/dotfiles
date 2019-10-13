#!/bin/bash

# create dir tree
mkdir ~/my_folder
mkdir ~/my_folder/projects
mkdir ~/my_folder/projects/test
mkdir ~/my_folder/other

# create global todo directory and file
mkdir ~/todo
# if use todo sync
if [ -z "$TODO_REMOTE_URL" ]
then
    git clone $TODO_REMOTE_URL ~/todo
    if ! test -f ~/todo/todo.yml;
    then
        touch ~/todo/todo.yml
    fi
else
    touch ~/todo/todo.yml
fi
