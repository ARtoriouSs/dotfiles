#!/bin/bash
# Claude Code statusline: dir name, git branch, logged in account, caveman badge

config_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd')

# Last part of the path only
printf '\033[1;38;5;208m%s\033[00m' "$(basename "$cwd")"

# Git branch, skipped outside a repo
branch=$(git --no-optional-locks -C "$cwd" branch --show-current 2>/dev/null)
[ -n "$branch" ] && printf ' \033[1;38;5;39m%s\033[00m' "$branch"

# Claude account of the current config dir
account=$(jq -r '.oauthAccount.emailAddress // empty' "$config_dir/.claude.json" 2>/dev/null)
[ -n "$account" ] && printf ' \033[01;32m%s\033[00m' "$account"

# Caveman badge, glob keeps it working after plugin updates change the hash
for caveman in "$config_dir"/plugins/cache/caveman/caveman/*/src/hooks/caveman-statusline.sh; do
  [ -f "$caveman" ] || continue
  badge=$(bash "$caveman")
  [ -n "$badge" ] && printf ' %s' "$badge"
  break
done
