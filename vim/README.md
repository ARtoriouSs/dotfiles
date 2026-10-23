# vim

Neovim config in Lua. `init.lua` and `lua/` are linked to `~/.config/nvim`, plugins are managed by
[lazy.nvim](https://github.com/folke/lazy.nvim).

| File                                                         | What it does                                             |
|--------------------------------------------------------------|----------------------------------------------------------|
| [init.lua](init.lua)                                         | Loads the modules below and sets a few global options    |
| [lazy-lock.json](lazy-lock.json)                             | Plugin versions, so a reinstall gets the same ones       |
| [lua/_plugins.lua](lua/_plugins.lua)                         | Plugin list                                              |
| [lua/_lsp.lua](lua/_lsp.lua)                                 | LSP servers (ruby-lsp)                                   |
| [lua/_completion.lua](lua/_completion.lua)                   | Completion with nvim-cmp                                 |
| [lua/_treesitter.lua](lua/_treesitter.lua)                   | Syntax highlighting with treesitter                      |
| [lua/_search.lua](lua/_search.lua)                           | Telescope search                                         |
| [lua/_explorer.lua](lua/_explorer.lua)                       | File explorer                                            |
| [lua/_editing.lua](lua/_editing.lua)                         | Editing options and key maps                             |
| [lua/_development.lua](lua/_development.lua)                 | Run specs and commands in the tmux pane beside           |
| [lua/_development_breakpoints.lua](lua/_development_breakpoints.lua) | `<Leader>p` inserts a breakpoint for the buffer's language |
| [lua/_git.lua](lua/_git.lua)                                 | Git integration                                          |
| [lua/_styling.lua](lua/_styling.lua)                         | Theme and look                                           |

`:Lazy update` updates plugins and writes new versions to `lazy-lock.json` through the link, commit it after.
`:Lazy restore` goes back to the versions in the lockfile.
