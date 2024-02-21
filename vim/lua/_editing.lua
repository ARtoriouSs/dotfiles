-- global options
vim.wo.wrap = false -- don't wrap lines
vim.o.clipboard = 'unnamedplus' -- use system clipboard by default if no register specified
vim.opt.updatetime = 100 -- update faser
vim.o.autoread = true -- to autoread if file was changed outside from vim
vim.o.path = vim.o.path .. "**" -- allows gf to look deep into folders during search

vim.g.scrolloff_fraction = 0.2 -- auto scroll on 20% of window width

-- tabs and indentation
vim.o.tabstop = 2 -- tab = two spaces
vim.o.shiftwidth = 2 -- identation in normal mode pressing < or >
vim.o.softtabstop = 2 -- set tab as 2 spaces and removes 2 spaces on backspace
vim.o.expandtab = true -- replaces tabs with spaces
vim.o.smarttab = true -- use shiftwidth instead of tabstop at start of lines
vim.o.autoindent = true -- copy indent from current line when starting a new line
vim.o.smartindent = true -- does smart autoindenting in C-like code

-- search
vim.o.ignorecase = true -- the case of normal letters is ignored
vim.o.smartcase = true -- overrides ignorecase if search contains uppercase chars
vim.api.nvim_set_keymap('v', '//', "y/<C-R>=escape(@\",'/')<CR><CR>", { noremap = true }) -- // in visual mode to search selected text
vim.api.nvim_set_keymap('n', '<C-x>', ':let @/ = ""<CR>', { noremap = true }) -- clear search buffer

-- splits
vim.opt.splitbelow = true -- open new horizontal split below
vim.opt.splitright = true -- open new vertical split to the right

-- easier split navigation ctrl + h/j/k/l
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W><C-j>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W><C-k>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W><C-l>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W><C-h>', { noremap = true })

-- tabs
vim.api.nvim_set_keymap('n', '<C-a>', ':tabprevious<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-q>', ':tabclose<CR>', { noremap = true })

-- folding
vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- TODO
vim.o.foldlevel = 99

-- command without shift
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })

-- use alt + d to delete without copying and alt + p in visual mode to paste without copying selection
vim.api.nvim_set_keymap('n', '<M-d>', '"_d', { noremap = true })
vim.api.nvim_set_keymap('x', '<M-d>', '"_d', { noremap = true })
vim.api.nvim_set_keymap('x', '<M-p>', '"_dp', { noremap = true })

-- use alt + w/e/b to navigate by word parts in normal and visual mode
vim.api.nvim_set_keymap('n', '<M-w>', '<Plug>CamelCaseMotion_w', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<M-e>', '<Plug>CamelCaseMotion_e', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', '<M-b>', '<Plug>CamelCaseMotion_b', { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<M-w>', '<Plug>CamelCaseMotion_w', { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<M-e>', '<Plug>CamelCaseMotion_e', { noremap = false, silent = true })
vim.api.nvim_set_keymap('v', '<M-b>', '<Plug>CamelCaseMotion_b', { noremap = false, silent = true })

-- use alt + arrows to navigate by word parts in normal and insert mode
vim.api.nvim_set_keymap('i', '<M-Left>',  '<C-o><Plug>CamelCaseMotion_b', { noremap = false, silent = true })
vim.api.nvim_set_keymap('i', '<M-Right>', '<C-o><Plug>CamelCaseMotion_w', { noremap = false, silent = true })

-- make < > shifts keep selection
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })

-- edit files in dotfiles dir (not $MYVIMRC) to have access to git inside vim (symlinked to $MYVIMRC)
vim.api.nvim_create_user_command('Vimrc', ':edit $DOTFILES_VIM/init.lua', {bang = true})
vim.api.nvim_create_user_command('Init', ':Vimrc', {bang = true})
vim.api.nvim_create_user_command('Plugins', ':edit $DOTFILES_VIM/lua/_plugins.lua', {bang = true})
vim.api.nvim_create_user_command('Todo', ':edit $HOME/todo.yml', {bang = true}) -- edit global todo
vim.api.nvim_create_user_command('Todol', ':edit todo.yml', {bang = true}) -- edit local todo

-- aliases
vim.api.nvim_create_user_command('Reload', 'source $MYVIMRC | redraw!', {bang = true}) -- redraw and reload configuration TODO: https://stackoverflow.com/questions/72412720/how-to-source-init-lua-without-restarting-neovim
vim.api.nvim_create_user_command('Q', 'q', {bang = true}) -- Q to exit
vim.api.nvim_create_user_command('Cc', 'let @+ = expand(\'%\')', {bang = true}) -- copy path to current file
vim.api.nvim_create_user_command('Ccl', 'let @+ = expand(\'%\') . \':\' . line(".")', {bang = true}) -- copy 'path/to/current/file:cursor_line'

-- filetype aliases
vim.api.nvim_create_user_command('Ruby', 'set filetype=ruby', {bang = true})
vim.api.nvim_create_user_command('Elixir', 'set filetype=elixir', {bang = true})
vim.api.nvim_create_user_command('Js', 'set filetype=javascript', {bang = true})
vim.api.nvim_create_user_command('JS', 'set filetype=javascript', {bang = true})
vim.api.nvim_create_user_command('Sql', 'set filetype=sql', {bang = true})
vim.api.nvim_create_user_command('SQL', 'set filetype=sql', {bang = true})
vim.api.nvim_create_user_command('Json', 'set filetype=json', {bang = true})
vim.api.nvim_create_user_command('JSON', 'set filetype=json', {bang = true})
vim.api.nvim_create_user_command('Xml', 'set filetype=xml', {bang = true})
vim.api.nvim_create_user_command('XML', 'set filetype=xml', {bang = true})

-- save actions
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '', command = ":%s/\\s\\+$//e" }) -- removes trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '', command = ":%s/\\n\\+\\ze\\%$//e" }) -- removes trailing eol on save

-- commenting
require('Comment').setup({
  padding = true,

  -- normal mode mappings
  toggler = {
    line = '<leader>c',
    block = '<leader>bc',
  },

  -- visual modes mappings
  opleader = {
    line = '<leader>c',
    block = '<leader>bc',
  },
})
