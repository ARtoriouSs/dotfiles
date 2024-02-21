require('_plugins')
require('_lsp')
require('_completion')
require('_treesitter')
require('_search')
require('_explorer')
require('_editing')
require('_development')
require('_git')
require('_styling')

vim.o.shellcmdflag = '-ic' -- run shell in interactive mode to load functions and aliases from the shell config
vim.opt.maxmempattern = 5000 -- more memory for regex searches
vim.opt.swapfile = false -- do not create swap files
