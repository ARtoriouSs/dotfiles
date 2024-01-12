local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr}) -- :help lsp-zero-keybindings
end)

-- language server manager - :help lsp-zero-guide:integrate-with-mason-nvim
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'solargraph'},
  handlers = {
    lsp_zero.default_setup,
  }
})
