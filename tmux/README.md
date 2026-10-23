# tmux

| File                                    | What it does                                                                 |
|-----------------------------------------|------------------------------------------------------------------------------|
| [.tmux.conf](.tmux.conf)                | Prefix `C-a`, pane switching with `Alt` + arrows or `hjkl`, system clipboard. Linked to `~/.tmux.conf` |
| [helpers.sh](helpers.sh)                | Functions to open, find and control project sessions                         |
| [workmux/config.yaml](workmux/config.yaml) | Global [workmux](https://github.com/raine/workmux) config. Linked to `~/.config/workmux/config.yaml` |
| [workmux/link-env.sh](workmux/link-env.sh) | Links untracked `.env*` files from the main checkout into a new worktree |

## Sessions

- `tp [path]` - project session: editor on top, shell and Claude below. `tc` opens it for `$CURRENT_PROJECT`
- `td [path]` - simple session with two panes
- `tk [name]` - kill the session of the current directory, `tka` kills all sessions
- `wmx` - open the repo or worktree with workmux in a separate tmux server, with the same layout as `tp`

`run-in-editor` and `run-beside` send commands to the editor pane and the pane beside it,
the Neovim config uses them to run specs and git commands.
