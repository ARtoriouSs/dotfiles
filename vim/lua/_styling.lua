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

require('ibl').setup() -- indent lines

require('lualine').setup({
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = {
      {
        'navic',
        color_correction = nil,
        navic_opts = {
          click = true
        }
      }
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  }
})

-- tab line
require('tabline').setup({
  padding = 2,
  show_icon = false,
})
