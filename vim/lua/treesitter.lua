require'nvim-treesitter.configs'.setup {
  ensure_installed = { "ruby", "elixir", "javascript", "lua", "sql", "html", "vim", "yaml", "markdown", "tsx", "bash" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- Intentation module
  indent = {
    enable = true
  },

  -- Add ends automatically
  endwise = {
    enable = true
  },

  -- treesitter based highlighting
  highlight = {
    enable = true,

    -- Disable slow treesitter highlight for large files
    --disable = function(lang, buf)
      --local max_filesize = 100 * 1024 -- 100 KB
      --local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      --if ok and stats and stats.size > max_filesize then
        --return true
      --end
    --end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time, can be a list of languages
    additional_vim_regex_highlighting = false,
  }
}
