-- disable default netrw explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- copy in status line
local function copy_file_to(node)
  local file_src = node['absolute_path']
  local file_out = vim.fn.input('Copy to: ', file_src, 'file')
  local dir = vim.fn.fnamemodify(file_out, ':h')

  vim.fn.system { 'mkdir', '-p', dir }
  vim.fn.system { 'cp', '-R', file_src, file_out }
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<C-e>', ':WinResizerStartResize<cr>', opts('winresizer override')) -- nvim-tree remaps C-e, so this line overrides it back to toggle WinResizer
  vim.keymap.set('n', 'r', api.fs.rename_sub, opts('move')) -- move/rename a file TODO: leave base name in prompt
  vim.keymap.set('n', 'm', api.fs.rename_sub, opts('move'))
  vim.keymap.set('n', 'z', api.fs.copy.node, opts('clipboard')) -- copy to clipboard
  vim.keymap.set('n', 'c', function() -- command line copy
    local node = api.tree.get_node_under_cursor()
    copy_file_to(node, true)
  end, opts('copy_file_to'))
end

require('nvim-tree').setup {
  on_attach = on_attach,
}

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<cr>', { silent = true, noremap = true })
vim.keymap.set('n', '<Leader>n', ':NvimTreeFindFile<cr>', { silent = true, noremap = true })
