#!/bin/bash
set -o pipefail # a pipeline fails when any command in it fails, not only the last one

# create dir tree
mkdir --parents ~/my_folder/projects/test
mkdir --parents ~/my_folder/other
mkdir --parents ~/my_folder/bin
mkdir --parents ~/my_folder/media/wallpapers

# create global todo file
touch ~/todo.yml
