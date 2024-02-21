vim.opt.background = 'dark'

require('gruvbox').setup({
  italic = {
    strings = false,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  }
})

vim.cmd("colorscheme gruvbox")

-- viewport
vim.opt.cursorline = true -- shows cursorline
vim.opt.number = true -- shows current line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.signcolumn = 'yes' -- sign column, `number` to be single width and replace line numbers
vim.opt.colorcolumn = '121' -- vertical line on 121'st column
vim.opt.list = true
vim.opt.listchars:append({ tab = '▸ ' })
vim.opt.listchars:append({ eol = '¬' })
vim.opt.listchars:append({ trail = '∙' })

-- animations
require('mini.animate').setup({
  -- Disable scroll animations
  scroll = {
    enable = false
  }
})
