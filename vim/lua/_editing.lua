-- global options
vim.wo.wrap = false             -- don't wrap lines
vim.o.clipboard = 'unnamedplus' -- use system clipboard by default if no register specified
vim.opt.updatetime = 100        -- update faser
vim.o.autoread = true           -- to autoread if file was changed outside from vim
vim.o.path = vim.o.path .. '**' -- allows gf to look deep into folders during search
vim.o.undofile = true           -- save undo history to be accessible between sessions
vim.o.undodir = '~/.vim/undo'   -- file for undo history

vim.g.scrolloff_fraction = 0.2  -- auto scroll on 20% of window width

-- indentation
vim.o.tabstop = 2        -- tab = two spaces
vim.o.shiftwidth = 2     -- indentation in normal mode pressing < or >
vim.o.softtabstop = 2    -- set tab as 2 spaces and removes 2 spaces on backspace
vim.o.expandtab = true   -- replaces tabs with spaces
vim.o.smarttab = true    -- use shiftwidth instead of tabstop at start of lines
vim.o.autoindent = true  -- copy indent from current line when starting a new line
vim.o.smartindent = true -- does smart autoindenting in C-like code

-- search
vim.o.ignorecase = true  -- the case of normal letters is ignored
vim.o.smartcase = true   -- overrides ignorecase if search contains uppercase chars
vim.keymap.set('v', '//', "y/<C-R>=escape(@\",'/')<CR><CR>", { noremap = true }) -- // in visual mode to search selected text
vim.keymap.set('n', '<C-x>', ':let @/ = ""<CR>', { noremap = true })             -- clear search buffer

-- splits
vim.opt.splitbelow = true -- open new horizontal split below
vim.opt.splitright = true -- open new vertical split to the right

-- easier split navigation ctrl + h/j/k/l
vim.keymap.set('n', '<C-j>', '<C-W><C-j>', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-W><C-k>', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-W><C-l>', { noremap = true })
vim.keymap.set('n', '<C-h>', '<C-W><C-h>', { noremap = true })

-- tabs
vim.keymap.set('n', '<C-a>', ':tabprevious<CR>', { noremap = true })
vim.keymap.set('n', '<C-s>', ':tabnext<CR>', { noremap = true })
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', { noremap = true })
vim.keymap.set('n', '<C-q>', ':tabclose<CR>', { noremap = true })
-- leader + number to switch tabs
vim.keymap.set('n', '<Leader>1', '1gt', { noremap = false, silent = true })
vim.keymap.set('n', '<Leader>2', '2gt', { noremap = false, silent = true })
vim.keymap.set('n', '<Leader>3', '3gt', { noremap = false, silent = true })
vim.keymap.set('n', '<Leader>4', '4gt', { noremap = false, silent = true })
vim.keymap.set('n', '<Leader>5', '5gt', { noremap = false, silent = true })
vim.keymap.set('n', '<Leader>6', '6gt', { noremap = false, silent = true })
vim.keymap.set('n', '<Leader>7', '7gt', { noremap = false, silent = true })
vim.keymap.set('n', '<Leader>8', '8gt', { noremap = false, silent = true })
vim.keymap.set('n', '<Leader>9', '9gt', { noremap = false, silent = true })
vim.keymap.set('n', '<Leader>0', ':tablast<CR>', { noremap = false, silent = true })

-- folding
vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()' -- TODO
vim.o.foldlevel = 99

-- command without shift
vim.keymap.set('n', ';', ':', { noremap = true })
vim.keymap.set('v', ';', ':', { noremap = true })

-- use alt + d to delete without copying and alt + p in visual mode to paste without copying selection
vim.keymap.set('n', '<M-d>', '"_d', { noremap = true })
vim.keymap.set('x', '<M-d>', '"_d', { noremap = true })
vim.keymap.set('x', '<M-p>', '"_dp', { noremap = true })

-- make < > shifts keep selection
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- in visual mode, make ' behave like i', so: v'  == vi' (select text inside quotes), same for "
vim.keymap.set('x', "'", "i'", { noremap = true, silent = true })
vim.keymap.set('x', '"', 'i"', { noremap = true, silent = true })

-- edit todo files
vim.api.nvim_create_user_command('Todo', ':edit $HOME/todo.yml', { bang = true }) -- edit global todo
vim.api.nvim_create_user_command('Todol', ':edit todo.yml', { bang = true })      -- edit local todo

-- aliases
vim.api.nvim_create_user_command('Q', 'q', { bang = true })                                            -- Q to exit
vim.api.nvim_create_user_command('Cc', 'let @+ = expand(\'%\')', { bang = true })                      -- copy path to current file
vim.api.nvim_create_user_command('Ccl', 'let @+ = expand(\'%\') . \':\' . line(".")', { bang = true }) -- copy 'path/to/current/file:cursor_line'

-- filetype aliases
vim.api.nvim_create_user_command('Ruby', 'set filetype=ruby', { bang = true })
vim.api.nvim_create_user_command('Elixir', 'set filetype=elixir', { bang = true })
vim.api.nvim_create_user_command('Js', 'set filetype=javascript', { bang = true })
vim.api.nvim_create_user_command('JS', 'set filetype=javascript', { bang = true })
vim.api.nvim_create_user_command('Sql', 'set filetype=sql', { bang = true })
vim.api.nvim_create_user_command('SQL', 'set filetype=sql', { bang = true })
vim.api.nvim_create_user_command('Json', 'set filetype=json', { bang = true })
vim.api.nvim_create_user_command('JSON', 'set filetype=json', { bang = true })
vim.api.nvim_create_user_command('Xml', 'set filetype=xml', { bang = true })
vim.api.nvim_create_user_command('XML', 'set filetype=xml', { bang = true })
vim.api.nvim_create_user_command('YML', 'set filetype=yaml', { bang = true })
vim.api.nvim_create_user_command('Yml', 'set filetype=yaml', { bang = true })
vim.api.nvim_create_user_command('YAML', 'set filetype=yaml', { bang = true })
vim.api.nvim_create_user_command('Yaml', 'set filetype=yaml', { bang = true })

-- Interactive shell is needed to load helpers, however jq outputs ZLE error in interactive mode,
-- so drop -i just for this run. Simpler version just incase:
-- vim.api.nvim_create_user_command('Jq', ':%!jq .', { bang = true }) -- format JSON
vim.api.nvim_create_user_command("Jq", function(opts)
  local shellcmdflag = vim.o.shellcmdflag
  vim.o.shellcmdflag = "-c" -- drop the -i just for this run
  pcall(vim.cmd, string.format([[%d,%d!jq .]], opts.line1, opts.line2))
  vim.o.shellcmdflag = shellcmdflag
end, { range = true })

for _, name in ipairs({ "JJ", "Jj" }) do -- JJ/Jj = Jq + JSON
  vim.api.nvim_create_user_command(name, function()
    vim.cmd("Jq")
    vim.cmd("JSON")
  end, {})
end

-- save actions
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '', command = ":%s/\\s\\+$//e" })        -- removes trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '', command = ":%s/\\n\\+\\ze\\%$//e" }) -- removes trailing eol on save

-- undo history
vim.keymap.set('n', '<C-u>', ':MundoToggle<CR>', { noremap = true })

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

-- filetype autocommands
local filetype_mapping = {
  ['*.jbuilder'] = 'ruby',
  ['.env.*'] = 'sh',
  ['Procfile'] = 'sh',
  ['.vimrc.*'] = 'vim',
  ['.gemrc'] = 'yaml',
  ['*.zsh-theme'] = 'zsh',
  ['.{jscs,jshint,eslint}rc'] = 'json',
  ['coc-settings.json'] = 'jsonc',
}

for pattern, type in pairs(filetype_mapping) do
  vim.api.nvim_create_autocmd(
    { 'BufNewFile', 'BufRead' },
    {
      pattern = pattern,
      callback = function()
        vim.api.nvim_set_option_value('filetype', type, { buf = vim.api.nvim_get_current_buf() })
      end
    }
  )
end

local open_navbuddy = function()
  require("nvim-navbuddy").open()
end
vim.keymap.set({ 'n', 'v' }, '<Leader>a', open_navbuddy, { noremap = false, silent = true })

-- vim-matchup configuration
vim.g.matchup_matchparen_offscreen = { method = "popup" }
vim.g.matchup_surround_enabled = 1
