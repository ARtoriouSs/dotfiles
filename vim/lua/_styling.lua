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

-- hide component if window is too narrow
local function trunc(hide_width)
  return function(str)
    if hide_width and vim.fn.winwidth(0) < hide_width then
      return ''
    else
      return str
    end
  end
end

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
    lualine_x = {
      { 'encoding', fmt = trunc(100) },
      { 'fileformat', fmt = trunc(100) },
      { 'filetype', fmt = trunc(100) }
    },
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
  },
  tabline = {
    lualine_a = {
      {
        'tabs',
        mode = 2, -- 0 - show only tab number, 1 - show file name, 2 - show both
        show_modified_status = true,
        symbols = {
          modified = ' [+]'
        },
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'buffers' }
  }
})
