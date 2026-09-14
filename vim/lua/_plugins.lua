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
  { -- should be first
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        opts = { lsp = { auto_attach = true } },
        dependencies = {
          "MunifTanjim/nui.nvim",
          {
            "SmiteshP/nvim-navic",
            opts = { lsp = { auto_attach = true } }
          }
        }
      }
    }
  },
  { 'williamboman/mason.nvim' }, -- language server manager
  { 'williamboman/mason-lspconfig.nvim' },

  -- treesitter
  -- the `main` branch is a full rewrite and does not support lazy-loading
  { 'nvim-treesitter/nvim-treesitter', branch = 'main', lazy = false, build = ':TSUpdate' },
  { -- complete do-end with treesitter
    'RRethy/nvim-treesitter-endwise',
    -- `master` needs nvim-treesitter's module system, which the `main` branch dropped;
    -- this branch talks to the core treesitter API instead
    branch = 'refactor/migrate-to-stable-treesitter-api',
  },
  { 'andymass/vim-matchup' }, -- better % matching with treesitter support

  -- completion & AI
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'github/copilot.vim' },

  -- search
  -- pinned to the default branch: the 0.1.x line drives previews through
  -- nvim-treesitter's removed module APIs, master uses core treesitter instead
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
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
  {
    'Wansmer/treesj', -- split/join args and hashes (<space>m toggle, <space>s split, <space>j join)
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {}
  },
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
  { 'nvim-tree/nvim-web-devicons' }, -- icons needed for several plugins
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } }, -- status, tab and win lines
  { 'ellisonleao/gruvbox.nvim', priority = 1000 , config = true } -- theme
})
