local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr}) -- :help lsp-zero-keybindings
end)

-- language server manager - :help lsp-zero-guide:integrate-with-mason-nvim
require('mason').setup({})
require('mason-lspconfig').setup({
  -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
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
  handlers = {
    lsp_zero.default_setup,
  }
})
