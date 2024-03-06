require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'ruby',
    'elixir',
    'javascript',
    'typescript',
    'tsx',
    'c',
    'lua',
    'sql',
    'bash',
    'vim',
    'html',
    'yaml',
    'jsonc',
    'markdown'
  },
  sync_install = false, -- install parsers synchronously (only applied to `ensure_installed`)
  auto_install = true,  -- automatically install missing parsers when entering buffer

  -- indentation module
  indent = {
    enable = true
  },

  -- add ends automatically
  endwise = {
    enable = true
  },

  -- treesitter based highlighting
  highlight = {
    enable = true,

    -- disable slow treesitter highlighting for large files
    disable = function(_lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- run `:h syntax` and tree-sitter at the same time, can be a list of languages
    additional_vim_regex_highlighting = false,
  }
}
