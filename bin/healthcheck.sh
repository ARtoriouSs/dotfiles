#!/bin/bash
set -o pipefail # a pipeline fails when any command in it fails, not only the last one

# checks installed programs, dotfile links and shell setup
# exits with 1 when something is missing, so it can be used in scripts and CI

failed=0

ok() {
  printf " $(tput setaf 10)✓  %s$(tput sgr0)\n" "$1"
}

fail() {
  printf " $(tput setaf 9)✗  %s$(tput sgr0)\n" "$1"
  failed=1
}

check() {
  if command -v $1 &> /dev/null; then
    ok "$1"
  else
    fail "$1"
  fi
}

# check that a file exists, for apps that are not in PATH
check-file() {
  if test -e "$1"; then
    ok "$2"
  else
    fail "$2"
  fi
}

# print a path with ~ instead of the home directory
short-path() {
  case "$1" in
    "$HOME"/*) echo "~${1#$HOME}" ;;
    *) echo "$1" ;;
  esac
}

# check that a link points to the expected file in dotfiles
check-link() {
  local link=$1 target=$2

  if [ -L "$link" ] && [ "$(readlink -f "$link")" = "$(readlink -f "$target")" ]; then
    ok "$(short-path "$link")"
  elif [ -e "$link" ] || [ -L "$link" ]; then
    fail "$(short-path "$link") is not a link to $(short-path "$target")"
  else
    fail "$(short-path "$link") is missing"
  fi
}

# check if snap enabled and installed
check-snap() {
  if command -v snap &> /dev/null; then
    ok "snap"
  elif test -f "/etc/apt/preferences.d/nosnap.pref"; then
    ok "snap disabled"
  else
    fail "snap"
  fi
}

# check if a Claude Code plugin is installed
check-plugin() {
  if grep -q "\"$1@" ~/.claude/plugins/installed_plugins.json 2>/dev/null; then
    ok "$1 (plugin)"
  else
    fail "$1 (plugin)"
  fi
}

echo "CLI base:"
check zsh
check nvim
check tree-sitter
check chafa
check batcat # bat is packaged as batcat on Debian/Ubuntu
check tmux
check rg
check ag
check fzf
check jq
check markdown
check diff-so-fancy
check cowsay
check gh
check glab
check grub-customizer
check asdf
check htop
check gitleaks
if [ "$(git -C ~/dotfiles config core.hooksPath)" = ".githooks" ]; then
  ok "dotfiles pre-commit hook"
else
  fail "dotfiles pre-commit hook, run: git -C ~/dotfiles config core.hooksPath .githooks"
fi

echo "Docker:"
check docker
if docker compose version &> /dev/null; then
  ok "docker compose"
else
  fail "docker compose"
fi

echo "Python:"
check python
check python3
check pip
check pip3

echo "Ruby:"
check ruby
check rbenv
check bundler

echo "Erlang and Elixir:"
check kerl
check kiex

echo "JavaScript:"
check node
check npm
check n
check yarn

echo "Go:"
check go

echo "Databases:"
check psql
check redis-server
check redis-cli

echo "AI agents:"
check claude
check gemini
check codex
check copilot

echo "AI tooling:"
check rtk
check caveman
check workmux

echo "Claude plugins:"
check-plugin superpowers
check-plugin ruby-lsp
check-plugin find-skills
check-plugin caveman
check-plugin workmux-status
check-file ~/.claude/skills/lavish/SKILL.md "lavish (skill)"

echo "GUI apps:"
check google-chrome
check telegram-desktop
check slack
check discord
check insomnia
check-file /opt/Postman/app/Postman "postman"

echo "GUI:"
if [ -n "$DISPLAY" ] && xset q &> /dev/null; then
  ok "display $DISPLAY reachable"
else
  fail "display ${DISPLAY:-unset} unreachable"
fi

echo "Snap status:"
check-snap

echo "Dotfile links:"
# create_symlinks.sh
check-link ~/.gitconfig ~/dotfiles/git/.gitconfig
check-link ~/.tmux.conf ~/dotfiles/tmux/.tmux.conf
check-link ~/.gemrc ~/dotfiles/development/.gemrc
check-link ~/.pryrc ~/dotfiles/development/.pryrc
check-link ~/.agignore ~/dotfiles/system/.agignore
# install_zsh.sh
check-link ~/.zshrc ~/dotfiles/system/.zshrc
check-link ~/.zprofile ~/dotfiles/system/.zprofile
# install_vim.sh
check-link ~/.config/nvim/init.lua ~/dotfiles/vim/init.lua
check-link ~/.config/nvim/lua ~/dotfiles/vim/lua
check-link ~/.config/nvim/lazy-lock.json ~/dotfiles/vim/lazy-lock.json
# install_rbenv.sh
check-link ~/.rbenv/default-gems ~/dotfiles/development/default-gems
# install_ai_agents.sh
check-link ~/.config/workmux/config.yaml ~/dotfiles/tmux/workmux/config.yaml
for profile in ~/.claude:work ~/.claude-work:work ~/.claude-personal:personal; do
  config_dir=${profile%:*}
  check-link "$config_dir/settings.json" ~/dotfiles/development/claude/"${profile##*:}"/settings.json
  check-link "$config_dir/statusline.sh" ~/dotfiles/development/claude/statusline.sh
  if [ "$config_dir" != ~/.claude ]; then
    check-link "$config_dir/CLAUDE.md" ~/.claude/CLAUDE.md
    check-link "$config_dir/RTK.md" ~/.claude/RTK.md
  fi
done

printf "\nChecking shell:\n"
if [ -z "$RC_SOURCED" ]; then
  fail "shell rc file is not sourced"
else
  ok "shell rc file is sourced"
fi

if [ -z "$PROFILE_SOURCED" ]; then
  fail "shell profile is not sourced, check if you are running login shell"
else
  ok "shell profile is sourced"

  # check dir tree if environment sourced
  if [ -d "$MY_FOLDER" ]; then
    ok "dir tree created"
  else
    fail "dir tree is not created"
  fi
fi

# return instead of exit when sourced, so the shell stays open
(return 0 2> /dev/null) && return $failed
exit $failed
