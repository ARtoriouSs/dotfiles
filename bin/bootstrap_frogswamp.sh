#!/usr/bin/env bash
# Prepares this PC to manage the frogswamp home server.
# Usage: bin/bootstrap_frogswamp.sh [path to the frogswamp repo, default ~/frogswamp]
# The real script lives in the frogswamp repo (scripts/bootstrap-local.sh). It's downloaded from
# GitHub so this PC gets the current version; if GitHub can't be reached, the local repo copy is used.
# The shell helpers it hooks up (ts-up, ts-down) stay here in frogswamp/helpers.sh. Safe to re-run
set -euo pipefail

repo_root="${1:-$HOME/frogswamp}"
url="https://raw.githubusercontent.com/ARtoriouSs/frogswamp/master/scripts/bootstrap-local.sh"
local_copy="$repo_root/scripts/bootstrap-local.sh"

script="$(mktemp)"
trap 'rm -f "$script"' EXIT
if curl -fsSL --max-time 30 "$url" -o "$script"; then
  echo "Using $url"
elif [ -f "$local_copy" ]; then
  echo "GitHub unreachable, using $local_copy" >&2
  cp "$local_copy" "$script"
else
  echo "Couldn't download $url and there is no $local_copy." >&2
  exit 1
fi
bash "$script" "$repo_root"
