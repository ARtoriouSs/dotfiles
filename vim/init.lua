require('_plugins')
require('_lsp')
require('_cmp')
require('_telescope')
require('_tree')
require('_treesitter')
require('_comment')
require('_theme')

vim.o.shellcmdflag = '-ic' -- run shell in interactive mode to load functions and aliases from the shell config

-- cursor
vim.o.cursorline = true -- shows cursorline
vim.o.number = true -- shows current line number
vim.o.relativenumber = true -- shows relative numbers

-- clipboard
vim.o.clipboard = 'unnamedplus' -- use system clipboard by default if no register specified

-- search
vim.o.ignorecase = true -- the case of normal letters is ignored
vim.o.smartcase = true -- overrides ignorecase if search contains uppercase chars

-- tabs and indentation
vim.o.tabstop = 2 -- tab = two spaces
vim.o.shiftwidth = 2 -- identation in normal mode pressing < or >
vim.o.softtabstop = 2 -- set tab as 2 spaces and removes 2 spaces on backspace
vim.o.expandtab = true -- replaces tabs with spaces
vim.o.smarttab = true -- use shiftwidth instead of tabstop at start of lines
vim.o.autoindent = true -- copy indent from current line when starting a new line
vim.o.smartindent = true -- does smart autoindenting in C-like code
-- make < > shifts keep selection
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true })


-- files
vim.o.autoread = true -- to autoread if file was changed outside from vim


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


vim.o.path = vim.o.path .. "**" -- allows gf to look deep into folders during search


-- // in visual mode to search selected text
vim.api.nvim_set_keymap('v', '//', "y/<C-R>=escape(@\",'/')<CR><CR>", { noremap = true })


-- folding
vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()" -- TODO
vim.o.foldlevel = 99


-- viewport and messages
vim.opt.list = true
vim.opt.listchars:append({ tab = '▸ ' })
vim.opt.listchars:append({ eol = '¬' })
vim.opt.listchars:append({ trail = '∙' })


vim.o.colorcolumn = '121' -- vertical line on 121'st column
vim.o.signcolumn = 'yes' -- sign column, `number` to be single width


-- use alt + d to delete without copying
vim.api.nvim_set_keymap('n', '<M-d>', '"_d', { noremap = true })
vim.api.nvim_set_keymap('x', '<M-d>', '"_d', { noremap = true })
-- use alt + p in visual mode to pase without copying selection
vim.api.nvim_set_keymap('x', '<M-p>', '"_dp', { noremap = true })


-- command without shift
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true })


-- clear search buffer
vim.api.nvim_set_keymap('n', '<C-x>', ':let @/ = ""<CR>', { noremap = true })

vim.api.nvim_create_user_command('Reload', 'source $MYVIMRC | redraw!', {bang = true}) -- redraw and reload configuration
vim.api.nvim_create_user_command('Q', 'q', {bang = true}) -- Q to exit

-- edit vimrc and plugins in dotfiles dir (not $MYVIMRC) to have access to git inside vim (symlinked to $MYVIMRC)
vim.api.nvim_create_user_command('Vimrc', ':edit $DOTFILES_VIM/init.lua', {bang = true})
vim.api.nvim_create_user_command('Init', ':Vimrc', {bang = true})
vim.api.nvim_create_user_command('Plugins', ':edit $DOTFILES_VIM/lua/_plugins.lua', {bang = true})


-- edit todo files
vim.api.nvim_create_user_command('Todo', ':edit $HOME/todo.yml', {bang = true})
vim.api.nvim_create_user_command('Todol', ':edit todo.yml', {bang = true})

vim.api.nvim_create_user_command('Cc', 'let @+ = expand(\'%\')', {bang = true}) -- copy path to current file
vim.api.nvim_create_user_command('Ccl', 'let @+ = expand(\'%\') . \':\' . line(".")', {bang = true}) -- copy 'path/to/current/file:cursor_line'

vim.opt.updatetime = 100 -- update faser

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


vim.api.nvim_create_user_command('Cs', 'let @+ = "spec " . expand(\'%\')', {bang = true}) -- copy 'spec path/to/current/file'
vim.api.nvim_create_user_command('Csl', 'let @+ = "spec " . expand(\'%\') . \':\' . line(".")', {bang = true}) -- copy 'spec path/to/current/file:cursor_line'

-- run current spec file in beside tmux pane
vim.api.nvim_create_user_command('Spec', "silent exec '!run-beside spec\\ ' . expand('%')", {bang = true})
vim.api.nvim_create_user_command('SPec', 'Spec', {bang = true})
vim.api.nvim_create_user_command('Specl', "silent exec '!run-beside spec\\ ' . expand('%') . ':' . line('%')", {bang = true})
vim.api.nvim_create_user_command('SPecl', "Specl", {bang = true})
vim.api.nvim_create_user_command('Speca', "silent exec '!run-beside spec'", {bang = true})
vim.api.nvim_create_user_command('SPeca', 'Speca', {bang = true})
vim.api.nvim_create_user_command('Bi', "silent exec '!run-beside bi'", {bang = true})


-- git
vim.opt.diffopt = vim.opt.diffopt + "vertical"
-- git and fugitive aliases

vim.api.nvim_create_user_command('Gst', ':Git', {bang = true})
vim.api.nvim_create_user_command('Gd', ':Gdiff', {bang = true})
vim.api.nvim_create_user_command('Gds', ':Gdiffsplit!', {bang = true})
vim.api.nvim_create_user_command('Gb', ':Git blame', {bang = true})
vim.api.nvim_create_user_command('Gcm', ':Git commit', {bang = true})
vim.api.nvim_create_user_command('Gca', ':Git commit --amend', {bang = true})
vim.api.nvim_create_user_command('Gcan', ':Git commit --amend --no-edit', {bang = true})
vim.api.nvim_create_user_command('Gl', ':Commits', {bang = true})
vim.api.nvim_create_user_command('Take', ':Gread | wq | q', {bang = true}) -- Take changes by fugitive's Gread and close splits
vim.api.nvim_create_user_command('Add', ":Git add % | silent exec '!status-beside'", {bang = true}) -- git add and show status in tmux pane beside


vim.api.nvim_create_user_command('Jq', ':%!jq .', {bang = true}) -- format JSON

vim.wo.wrap = false

vim.opt.maxmempattern = 5000


vim.g.scrolloff_fraction = 0.2 -- auto scroll on 20% of window width

-- use alt + w/e/b to navigate by word parts TODO - disable by default
--vim.cmd('g:wordmotion_nomap')
--vim.cmd("let g:wordmotion_mappings = {'w' : '<M-w>', 'b' : '<M-b>', 'e' : '<M-e>' }")

-- removes trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '', command = ":%s/\\s\\+$//e" })
-- removes trailing eol on save
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '', command = ":%s/\\n\\+\\ze\\%$//e" })


-- copilot
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
