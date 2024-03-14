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

require("ibl").setup() -- indent lines

local navic = require("nvim-navic")
-- require('lualine').setup() -- status line
require("lualine").setup({
  sections = {
    lualine_c = {
      {
        "navic",

        -- Component specific options
        color_correction = nil,         -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
        -- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
        -- Setting it to "static" will perform a adjustment once when the component is being setup. This should
        --   be enough when the lualine section isn't changing colors based on the mode.
        -- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
        --   the current section.

        navic_opts = nil         -- lua table with same format as setup's option. All options except "lsp" options take effect when set here.
      }
    }
  },
  -- OR in winbar
  -- winbar = {
  --   lualine_c = {
  --     {
  --       "navic",
  --       color_correction = nil,
  --       navic_opts = nil
  --     }
  --   }
  -- }
})




-- tab line
require('tabline').setup({
  padding = 2,
  show_icon = false,
})
