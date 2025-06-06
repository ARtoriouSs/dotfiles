# system
alias dog="cat" # the most important one
alias ccat="pygmentize -g -O style='colorful'" # colored cat
alias e="echo"
alias c="cd .."
alias psqlc="psql -U postgres"
alias todo="$VISUAL $TODO"
alias todol="$VISUAL todo.yml" # local todo
alias v=$VISUAL
alias search="find . -name" # search file by name
alias k9="kill -9"
alias upd="sudo apt update --yes"
alias upg="sudo apt upgrade --yes"
alias install="sudo apt --yes update; sudo apt --yes install"

alias susp="systemctl suspend"
alias shut="init 0"
alias halt="init 0"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# dotfiles quick access
alias cdd="cd ~/dotfiles"
alias zprofile="$VISUAL ~/dotfiles/system/.zprofile"
alias zshrc="$VISUAL ~/dotfiles/system/.zshrc"
alias envs="$VISUAL ~/dotfiles/system/environment.sh"
alias temps="$VISUAL ~/dotfiles/system/temp_settings.sh"
alias gitconfig="$VISUAL ~/dotfiles/git/.gitconfig"
alias gitignore-global="$VISUAL ~/dotfiles/git/.gitignore.global"
alias vimrc="$VISUAL ~/dotfiles/vim/init.lua"
alias plugins="$VISUAL ~/dotfiles/vim/lua/_plugins.lua"
alias tmux-conf="$VISUAL ~/dotfiles/tmux/.tmux.conf"
alias pryrc="$VISUAL ~/dotfiles/development/.pryrc"

# system files access
alias hosts="sudoedit /etc/hosts"
alias pg-hba="sudoedit /etc/postgresql/*/main/pg_hba.conf"

# some russian equivalents for wrong keyboard layout
alias "с"="cd .."
alias "св"="cd"

# some caps equivalents
alias "C"="c"
alias "CD"="cd"

# handy grep aliases from default .bashrc
if [ -x /usr/bin/dircolors ]; then
  alias grep="`which grep` --color=auto"
  alias fgrep="`which fgrep` --color=auto"
  alias egrep="`which egrep` --color=auto"
fi

# ls
alias ls='ls --color=auto -h'
alias la='ls -A'
alias l="la"
alias ll='ls -alh --color=auto --group-directories-first'

reload() {
  source ~/.zprofile
}

# open with default application
o() {
  [ -z "$1" ] && xdg-open . || xdg-open $@
}

# generate ctags
tags() {
  local git_dir=$(git --no-optional-locks rev-parse --git-dir)
  trap 'rm -f "$git_dir/$$.tags"' EXIT

  case "$1" in
    --rails) # add gems paths and cut off bundler warnings with awk
      ctags -f $git_dir/$$.tags . $(bundle list --paths | awk '/^\// { print $0 }')
    ;;
    --elixir)
      ctags --exclude=_build -f $git_dir/$$.tags .
    ;;
    --js)
      ctags --exclude=tmp -f $git_dir/$$.tags .
    ;;
    *)
      ctags -f $git_dir/$$.tags .
    ;;
  esac

  mv "$git_dir/$$.tags" "$git_dir/tags"
}

# display linux 256 colors
color-list() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i
    if ! (( ($i + 1) % 8 )); then
      echo
    fi
  done
}

# cd to $PROJECTS and farther
alias cdcc="cdp $CURRENT_PROJECT/.." # if project is in subdirectory
alias cdc="cdp $CURRENT_PROJECT"
alias cdt="cdp test"
cdp() {
  cd $PROJECTS/$1
}

# clean $PROJECTS/test directory
clean-test() {
  rm -rf $PROJECTS/test
  mkdir $PROJECTS/test
  cd $PROJECTS/test
  git init > /dev/null
  cd - > /dev/null
}

# copy to system clipboard
clip() {
  xclip -rmlastnl -selection clipboard $1
}

make-free-space() {
  sudo apt autoremove --purge # remove unused packages
  sudo flatpak repair # remove unused objects in /var/lib/flatpack/repo/objects
  sudo rm -rf /var/log/journal/* # remove logs
}

# show weather
wttr() {
  local url="wttr.in?FMp"

  case "$1" in
    1) url+='1' ;;
    2) url+='2' ;;
    3) ;;
    *) url+='0' ;;
  esac

  curl $url
}

# runs spec file 10 times 🙃 stops on fail
flaky-spec() {
  for i in {1..10}; do
    bundle exec rspec $@

    if [[ $? -ne 0 ]] ; then
      break
    fi
  done
}

# same as above, but 100 times
very-flaky-spec() {
  for i in {1..100}; do
    bundle exec rspec $@

    if [[ $? -ne 0 ]] ; then
      break
    fi
  done
}

proxy-up() {
  export http_proxy=$HTTP_PROXY_SERVER
  export https_proxy=$HTTPS_PROXY_SERVER
  export HTTP_PROXY=$HTTP_PROXY_SERVER
  export HTTPS_PROXY=$HTTPS_PROXY_SERVER
}

proxy-down() {
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
}

# Rescale the specified monitor (DP-4 by default) for big screens (Mint allows to scale 200+% only)
# https://askubuntu.com/questions/1029436/enable-fractional-scaling-for-ubuntu-18-04
# https://askubuntu.com/a/1056366/1113014
# xrandr --istmonitors to see the available displays
rescale() {
  [ -z "$1" ] && xrandr --output DP-4 --scale 1.5x1.5 || xrandr --output $@ --scale 1.5x1.5
}

descale() {
  [ -z "$1" ] && xrandr --output DP-4 --scale 0.8x0.8 || xrandr --output $@ --scale 0.8x0.8
}

# Reset scaling to default
rescale-default() {
  [ -z "$1" ] && xrandr --output DP-4 --scale 1x1 || xrandr --output $@ --scale 1x1
}

# Decrease keyboard repeat delay and increase speed
alias repeat="keyboard-repeat-reset"
keyboard-repeat-reset() {
  gsettings set org.gnome.desktop.peripherals.keyboard delay 200
  xset r rate 200 40
}
