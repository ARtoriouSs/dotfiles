-- Add cmp_nvim_lsp capabilities to all LSP configs before they are enabled.
-- vim.lsp.config('*', ...) extends the global configuration shared by servers.
vim.lsp.config('*', {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.config['*'] and vim.lsp.config['*'].capabilities or {},
    require('cmp_nvim_lsp').default_capabilities()
  )
})

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
    vim.keymap.set('n', 'gl', '<cmd>lua vim.lsp.buf.definition()<cr>', opts) -- go to definition with quickfix list
    vim.keymap.set('n', 'gd', function() -- go to definition without quickfix list
      local params = vim.lsp.util.make_position_params()
      vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, config)
        if err then
          vim.notify('Error getting definition: ' .. err.message, vim.log.levels.ERROR)
          return
        end
        if not result or vim.tbl_isempty(result) then
          vim.notify('No definition found', vim.log.levels.INFO)
          return
        end

        local first_result = result[#result] or result
        vim.lsp.util.jump_to_location(first_result, 'utf-8')
      end)
    end, opts)
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
-- TODO: duplicated refs:
---- https://github.com/nvim-telescope/telescope.nvim/issues/3328#issuecomment-2472420006
---- https://www.reddit.com/r/neovim/comments/19cvgtp/any_way_to_remove_redundant_definition_in_lua_file/
