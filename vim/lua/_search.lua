local telescope = require('telescope')
local builtin   = require('telescope.builtin')

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous
      }
    }
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
    }
  }
}

telescope.load_extension('fzf')

vim.keymap.set('n', '<leader>f', builtin.find_files, {}) -- FZF file search
vim.keymap.set('n', '<leader>g', builtin.live_grep,  {}) -- FZF grep search

-- find and replace
vim.keymap.set('v', '<Leader>d', '<Plug>CtrlSFVwordExec', { noremap = false, silent = true }) -- search for selected text
vim.keymap.set('n', '<Leader>d', '<Plug>CtrlSFPrompt', { noremap = false, silent = true }) -- open prompt
vim.keymap.set('n', '<C-G>', ':CtrlSFToggle<CR>', { noremap = false, silent = true }) -- toggle last search
vim.keymap.set('v', '<C-G>', ':CtrlSFToggle<CR>', { noremap = false, silent = true })
vim.keymap.set('i', '<C-G>', '<Esc>:CtrlSFToggle<CR>', { noremap = false, silent = true })

vim.g.ctrlsf_search_mode = 'async' -- recommended async mode
vim.g.ctrlsf_case_sensitive = 'yes'
vim.g.ctrlsf_auto_preview = 1 -- change preview file when jumping between results
vim.g.ctrlsf_context = '-C 5' -- 5 lines of context
vim.g.ctrlsf_auto_close = { normal = 0, compact = 0 } -- don't close when selecting a file
vim.g.ctrlsf_auto_focus = { at = 'start' } -- auto focus on start

-- buffer map
require("aerial").setup({
  backends = { 'lsp', 'treesitter', 'markdown', 'asciidoc', 'man' },
  default_direction = 'prefer_left',
  autojump = true,

  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- leader-a to toggle aerial
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>")
