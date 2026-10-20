#!/usr/bin/env bash
# Symlink untracked .env* files (at any depth) from the main checkout into a worktree
# Tracked files like .env.example are skipped, and ignored dirs like node_modules are not entered
set -euo pipefail

worktree=${WM_WORKTREE_PATH:-$(git rev-parse --show-toplevel)}
main=${WM_PROJECT_ROOT:-$(git -C "$worktree" worktree list --porcelain | sed -n '1s/^worktree //p')}

[ "$main" = "$worktree" ] && exit 0

{
  # ignored files, then untracked files that are not ignored (e.g. .env.play missing from .gitignore)
  git -C "$main" ls-files -z --others --ignored --exclude-standard --directory
  git -C "$main" ls-files -z --others --exclude-standard --directory
} |
  while IFS= read -r -d '' path; do
    case "${path##*/}" in
      .env*) ;;
      *) continue ;;
    esac
    mkdir -p "$worktree/$(dirname "$path")"
    ln -sfn "$main/$path" "$worktree/$path"
    echo "linked $path"
  done
