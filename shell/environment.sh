export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.rbenv/bin:$PATH

if [[ "$OSTYPE" == "darwin"* ]]; then
    export "PATH=/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
fi

export EDITOR=vim
export WORK_EDITOR=code
export SSH_KEY_PATH=~/.ssh/id_rsa
export EMAIL="artoriousso@gmail.com"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export FILE_MANAGER="nemo" # "nautilus"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export FILE_MANAGER="open"
fi

# directories and files access
export MY_FOLDER=~/my_folder
export PROJECTS=~/my_folder/projects
export DESKTOP=~/Desktop
export TODO=~/todo.yml
