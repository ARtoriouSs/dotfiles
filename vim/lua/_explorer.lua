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

local tree_actions = function(node)
  return {
    {
      name = 'create',
      handler = require('nvim-tree.api').fs.create,
    },
    {
      name = 'delete',
      handler = require('nvim-tree.api').fs.remove,
    },
    {
      name = 'rename',
      handler = require('nvim-tree.api').fs.rename,
    },
    {
      name = 'move',
      handler = require('nvim-tree.api').fs.rename_sub,
    },
    {
      name = 'clipboard',
      handler = require('nvim-tree.api').fs.copy.node,
    },
    {
      name = 'copy',
      handler = function(node)
        local node = require('nvim-tree.api').tree.get_node_under_cursor()
        copy_file_to(node, true)
      end,
    },
  }
end

local function tree_actions_menu(node)
  local entry_maker = function(menu_item)
    return {
      value = menu_item,
      ordinal = menu_item.name,
      display = menu_item.name,
    }
  end

  local finder = require('telescope.finders').new_table({
    results = tree_actions(node),
    entry_maker = entry_maker,
  })

  local sorter = require('telescope.sorters').get_generic_fuzzy_sorter()

  local default_options = {
    finder = finder,
    sorter = sorter,
    attach_mappings = function(prompt_buffer_number)
      local actions = require('telescope.actions')

      -- on item select
      actions.select_default:replace(function()
        local state = require('telescope.actions.state')
        local selection = state.get_selected_entry()
        actions.close(prompt_buffer_number) -- closing the picker
        selection.value.handler(node) -- executing the callback
      end)

      -- the following actions are disabled
      actions.add_selection:replace(function() end)
      actions.remove_selection:replace(function() end)
      actions.toggle_selection:replace(function() end)
      actions.select_all:replace(function() end)
      actions.drop_all:replace(function() end)
      actions.toggle_all:replace(function() end)

      return true
    end,
  }

  -- TODO: use cursor theme
  require('telescope.pickers').new({ prompt_title = 'Actions' }, default_options):find()
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'c', function()
    local node = api.tree.get_node_under_cursor()
    copy_file_to(node, true)
  end, opts('copy_file_to'))

  -- show actions menu in Telescope
  vim.keymap.set('n', 'm', tree_actions_menu, { buffer = bufnr, noremap = true, silent = true, nowait = true })
  -- move/rename a file TODO: leave base name in prompt
  vim.keymap.set('n', 'r', api.fs.rename_sub, opts('move'))
  -- nvim-tree remaps C-e, so this line overrides it back to toggle WinResizer
  vim.keymap.set('n', '<C-e>', ':WinResizerStartResize<cr>', opts('winresizer override'))
end

require('nvim-tree').setup {
  on_attach = on_attach,
}

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeFindFile<cr>', { silent = true, noremap = true })
