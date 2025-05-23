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
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'RRethy/nvim-treesitter-endwise' }, -- complete do-end with treesitter

  -- completion & AI
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'github/copilot.vim' },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"!
    opts = {
      provider = "claude",
      openai = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      }
    },
    keys = {
      { -- paste an image to the prompt
        "<leader>ip",
        function()
          return vim.bo.filetype == "AvanteInput" and require("avante.clipboard").paste_image()
            or require("img-clip").paste_image()
        end,
        desc = "clip: paste image",
      },
    },
    build = "make BUILD_FROM_SOURCE=true", -- just `make` to not build from source
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons",
      { -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- use_absolute_path = true -- required for Windows users
          },
        }
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      }
    }
  },

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
  { 'nvim-tree/nvim-web-devicons' }, -- icons needed for several plugins
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } }, -- status, tab and win lines
  { 'ellisonleao/gruvbox.nvim', priority = 1000 , config = true } -- theme
})
