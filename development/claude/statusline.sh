#!/bin/bash
# Claude Code statusline: dir name, git branch, logged in account, model, usage, caveman badge

config_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd')

# White middle dot before a segment, bold when the first argument is "bold"
separator() {
  if [ "$1" = "bold" ]; then
    printf ' \033[1;97m·\033[00m '
  else
    printf ' \033[97m·\033[00m '
  fi
}

# Last part of the path only
printf '\033[1;38;5;208m%s\033[00m' "$(basename "$cwd")"

# Git branch, skipped outside a repo
branch=$(git --no-optional-locks -C "$cwd" branch --show-current 2>/dev/null)
[ -n "$branch" ] && printf ' \033[1;38;5;39m%s\033[00m' "$branch"

# Claude account of the current config dir
account=$(jq -r '.oauthAccount.emailAddress // empty' "$config_dir/.claude.json" 2>/dev/null)
[ -n "$account" ] && separator bold && printf '\033[38;5;220m%s\033[00m' "$account"

# Model, context used and rate limits, each skipped when missing
model=$(printf '%s' "$input" | jq -r '.model.display_name // empty')
[ -n "$model" ] && separator bold && printf '\033[38;5;250m%s\033[00m' "$model"

context=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // empty')
[ -n "$context" ] && separator && printf '\033[38;5;244mctx %s%%\033[00m' "$context"

five_hour=$(printf '%s' "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
[ -n "$five_hour" ] && separator && printf '\033[38;5;244m5h %s%%\033[00m' "$five_hour"

seven_day=$(printf '%s' "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
[ -n "$seven_day" ] && separator && printf '\033[38;5;244m7d %s%%\033[00m' "$seven_day"

# Caveman badge, glob keeps it working after plugin updates change the hash
for caveman in "$config_dir"/plugins/cache/caveman/caveman/*/src/hooks/caveman-statusline.sh; do
  [ -f "$caveman" ] || continue
  badge=$(bash "$caveman")
  [ -n "$badge" ] && separator && printf '%s' "$badge"
  break
done
