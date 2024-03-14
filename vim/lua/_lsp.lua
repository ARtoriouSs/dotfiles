local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr }) -- :help lsp-zero-keybindings

  local opts = { buffer = bufnr }

  -- :Format to format
  vim.api.nvim_create_user_command(
    'Format',
    'lua vim.lsp.buf.format({async = false, timeout_ms = 10000})',
    { bang = true }
  )

  -- gq to format
  vim.keymap.set({ 'n', 'v', 'x' }, 'gq', function()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
  end, opts)

  -- set up navbuddy and navic when applicable
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navbuddy').attach(client, bufnr)
    require('nvim-navic').attach(client, bufnr)
  end
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- list of available servers: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
  ensure_installed = {
    'typos_lsp',
    'solargraph', -- Ruby
    'elixirls',
    'clangd',
    'lua_ls',
    'vimls',
    'bashls',
    'sqlls',
    'dockerls',
    'html',
    'cssls',
    'jsonls',
    'yamlls',
    'lemminx', -- XML
    'marksman' -- Markdown
  },

  -- server-specific configuration
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  handlers = {
    lsp_zero.default_setup,

    lua_ls = function()
      require('lspconfig').lua_ls.setup(lsp_zero.nvim_lua_ls()) -- nvim-specific lua config
    end
  }
})

-- disable yamlls for todo.yml files
vim.api.nvim_create_autocmd('BufEnter', { pattern = 'todo.yml', command = 'lua vim.diagnostic.disable()' })
