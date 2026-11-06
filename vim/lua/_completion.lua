require('blink.cmp').setup({
  keymap = {
    preset = 'default', -- <C-y> accepts, <Tab> jumps inside snippets and falls back to Copilot
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_next', 'snippet_backward', 'fallback' },
  },

  completion = {
    menu = { border = 'rounded' },
    documentation = { auto_show = true, window = { border = 'rounded' } },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})

vim.lsp.enable('ruby_lsp')
