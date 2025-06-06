-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

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

-- disable yamlls for todo.yml files
vim.api.nvim_create_autocmd('BufEnter', { pattern = 'todo.yml', command = 'lua vim.diagnostic.enable(false)' })

-- keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- TODO: lua_ls with vim
