local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- LSP
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'williamboman/mason.nvim'}, -- language server manager
  {'williamboman/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},
  {'L3MON4D3/LuaSnip'}, -- TODO: needed?

  -- treesitter
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  {'RRethy/nvim-treesitter-endwise'}, -- complete do-end with treesitter

  -- completion
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'github/copilot.vim'},

  -- search and modals
  {'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = {'nvim-lua/plenary.nvim'}},
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make', dependencies = {'nvim-telescope/telescope.nvim'}},

  -- file explorer
  {'nvim-tree/nvim-tree.lua'},
  {'nvim-tree/nvim-web-devicons'},

  -- git
  {'tpope/vim-fugitive'},
  {'airblade/vim-gitgutter'},

  -- life-simplifiers
  {'drzel/vim-scrolloff-fraction'}, -- scroll window when approaching the bottom/top
  {'simeji/winresizer'}, -- split resizer
  {'tpope/vim-eunuch'}, -- file operation commands
  {'bkad/CamelCaseMotion'}, -- jump between word parts
  {'tpope/vim-surround'}, -- quick change of parentheses, brackets, quotes, tags, etc.
  {'tpope/vim-repeat'}, -- repeat plugin commands with '.'
  { 'numToStr/Comment.nvim', lazy = false }, -- commenting

  -- theme
  {'ellisonleao/gruvbox.nvim', priority = 1000 , config = true},
})
