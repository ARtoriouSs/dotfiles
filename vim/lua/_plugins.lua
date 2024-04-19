local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- LSP
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  { 'williamboman/mason.nvim' }, -- language server manager
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'L3MON4D3/LuaSnip' },

  -- treesitter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'RRethy/nvim-treesitter-endwise' }, -- complete do-end with treesitter

  -- completion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'github/copilot.vim' },

  -- search
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', dependencies = { 'nvim-telescope/telescope.nvim' } },
  { 'dyng/ctrlsf.vim' }, -- find and replace

  -- navigation
  { 'nvim-tree/nvim-tree.lua' }, -- file explorer
  { 'drzel/vim-scrolloff-fraction' }, -- scroll window when approaching the bottom/top
  { 'SmiteshP/nvim-navic', dependencies = { 'neovim/nvim-lspconfig' } }, -- dynamic cursor position displaying
  { -- buffer map
    'SmiteshP/nvim-navbuddy',
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  { -- jump between word parts
    'chaoren/vim-wordmotion',
    init = function() -- due to nvim API limitations this plugin needs to be configured here
      -- use alt + w/e/b to navigate by word parts in normal and visual mode
      vim.cmd([[
        let g:wordmotion_mappings = { 'w': '<M-w>', 'b': '<M-b>', 'e': '<M-e>' }
      ]])
    end,
  },

  -- editing
  { 'simeji/winresizer' }, -- split resizer
  { 'tpope/vim-surround' }, -- quick change of parentheses, brackets, quotes, tags, etc.
  { 'tpope/vim-repeat' }, -- repeat plugin commands with '.'
  { 'tpope/vim-eunuch' }, -- file operation commands
  { 'numToStr/Comment.nvim', lazy = false }, -- commenting
  { 'simnalamburt/vim-mundo' }, -- undo tree

  -- git
  { 'tpope/vim-fugitive' },
  { 'airblade/vim-gitgutter' },

  -- styling
  { 'echasnovski/mini.animate' }, -- animations
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} }, -- indent lines
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } }, -- status, tab and win lines
  { 'nvim-tree/nvim-web-devicons' }, -- icons needed for several plugins
  { 'ellisonleao/gruvbox.nvim', priority = 1000 , config = true } -- theme
})
