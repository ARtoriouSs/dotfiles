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
  {'scrooloose/nerdtree'},
  {'Xuyuanp/nerdtree-git-plugin'},

  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'williamboman/mason.nvim'}, -- Language server manager
  {'williamboman/mason-lspconfig.nvim'},
  {'neovim/nvim-lspconfig'},
  {'L3MON4D3/LuaSnip'}, -- needed?

  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-cmdline'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},

  {'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = {'nvim-lua/plenary.nvim'}},

  {'nvim-tree/nvim-tree.lua'},
  {'nvim-tree/nvim-web-devicons'},

  {'ellisonleao/gruvbox.nvim', priority = 1000 , config = true},

  {'tpope/vim-fugitive'},
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  {'RRethy/nvim-treesitter-endwise'},

  {'drzel/vim-scrolloff-fraction'},
  {'airblade/vim-gitgutter'},
  {'simeji/winresizer'},
  {'tpope/vim-eunuch'},
  {'chaoren/vim-wordmotion'},
  {'tpope/vim-surround'},
  {'tpope/vim-repeat'},

  { 'numToStr/Comment.nvim', lazy = false },

  {'github/copilot.vim'},
})
