vim.opt.background = 'dark'

-- colorscheme
require('gruvbox').setup({
  italic = {
    strings = false,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  }
})

vim.cmd('colorscheme gruvbox')

-- viewport
vim.opt.cursorline = true     -- shows cursorline
vim.opt.number = true         -- shows current line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.signcolumn = 'yes'    -- sign column, `number` to be single width and replace line numbers
vim.opt.colorcolumn = '121'   -- vertical line on 121'st column
vim.opt.list = true
vim.opt.listchars:append({ tab = '▸ ' })
vim.opt.listchars:append({ eol = '¬' })
vim.opt.listchars:append({ trail = '∙' })

-- highlight trailing spaces
vim.cmd([[
  match TrailingSpace / \+$/
  highlight TrailingSpace guifg=red
]])

-- animations
require('mini.animate').setup({
  scroll = { enable = false },
  resize = { enable = false }
})

-- indent lines
require("ibl").setup()
require('lualine').setup() -- status line

-- tab line
require('tabline').setup({
  padding = 2,
  show_icon = false,
})

-- filetype autocommands
local filetype_mapping = {
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
        vim.api.nvim_buf_set_option(vim.api.nvim_get_current_buf(), 'filetype', type)
      end
    }
  )
end
