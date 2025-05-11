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
})

-- disable yamlls for todo.yml files
vim.api.nvim_create_autocmd('BufEnter', { pattern = 'todo.yml', command = 'lua vim.diagnostic.enable(false)' })

-- TODOs:
-- * lua_ls with vim
-- * lsp_zero.default_keymaps({ buffer = bufnr }) -- :help lsp-zero-keybindings
