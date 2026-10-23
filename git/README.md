# git

| File                                   | What it does                                                         |
|----------------------------------------|----------------------------------------------------------------------|
| [.gitconfig](.gitconfig)               | User, colors, aliases, signed commits, diff-so-fancy pager. Linked to `~/.gitconfig` |
| [.gitignore.global](.gitignore.global) | Files ignored in every repo (editor and OS files)                    |
| [helpers.sh](helpers.sh)               | Short git commands with a colored short status after each one        |

Most helpers work from any subdirectory of a repo, e.g. `add`, `stadd` and `reset` take paths from the repo root.
Some useful ones:

- `status` (`gst`) - colored `git status --short`
- `add`, `stadd` - add files, `stadd` picks them with fzf
- `commit` (`gcm`) - commit with all args as the message, `gcmm` adds the Jira ticket from the branch name
- `reset` - asks, then drops all changes and untracked files, `freset` does it without asking
- `push`, `pull`, `fpush` - work with the current branch on origin
- `ghpr`, `ghprc` - open a GitHub PR, `ghprc` takes the title from the first commit

## Trusted repos

`gtrust` creates `.git/safe` in a repo. After that:

- the repo's `bin/` is first in `PATH` when you are in the repo root (for binstubs like `bin/rails`)
- `.git/safe/default_branch` and `.git/safe/current_language` set the default branch and project language
  for the helpers here and in [development](../development)

Only trust your own repos: anything in their `bin/` can replace system commands.
