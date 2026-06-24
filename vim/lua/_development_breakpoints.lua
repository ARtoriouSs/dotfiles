-- <Leader>p: insert a breakpoint matching the buffer's language, then save.
-- When the cursor sits inside a single-line ("inline") block, the breakpoint is
-- injected at the start of the block body instead of on a new line below, e.g.
--   result = array.map { |value| value + 'foo' }
--   -> result = array.map { |value| binding.pry; value + 'foo' }
-- Block detection uses treesitter (LSP can't model anonymous inline blocks).
local M = {}

local breakpoints = {
  ruby = 'binding.pry',
  javascript = 'debugger;',
  javascriptreact = 'debugger;',
  typescript = 'debugger;',
  typescriptreact = 'debugger;',
  elixir = 'require IEx; IEx.pry',
}

-- Treesitter block node -> injection mode (node names verified via :InspectTree).
--   'insert' : chain the snippet with '; ' at the block body start.
--   'wrap'   : parenthesize the value so chained statements stay scoped (elixir `do:`).
-- Types are grammar-unique, so this doubles as the "is this a block?" predicate.
local blocks = {
  block           = 'insert', -- ruby   { |x| ... }
  do_block        = 'insert', -- ruby   do |x| ... end
  statement_block = 'insert', -- js/ts  => { ... }
  stab_clause     = 'insert', -- elixir fn x -> ... end
  pair            = 'wrap',   -- elixir if c, do: ...
}

-- Leading child node types to skip when locating a block's body (param/arg lists).
local skip = { block_parameters = true, arguments = true }

-- First named child that is actual body, not a parameter/argument list.
local function body_node(node)
  for child in node:iter_children() do
    if child:named() and not skip[child:type()] then
      return child
    end
  end
end

-- Describe how to inject the breakpoint into `node`, or nil if it has no usable body.
local function resolve(node, bufnr)
  local mode = blocks[node:type()]
  if mode == 'insert' then
    local body = body_node(node)
    if body then
      local r, c = body:start()
      return { mode = mode, row = r, col = c }
    end
  elseif mode == 'wrap' then -- elixir `do:`: keyword pair, wrap its value in ( ... )
    local kw, val
    for child in node:iter_children() do
      if child:named() then
        if child:type() == 'keyword' then kw = child
        elseif not val then val = child end
      end
    end
    if kw and val and vim.treesitter.get_node_text(kw, bufnr):match('^do') then
      local sr, sc = val:start()
      local er, ec = val:end_()
      return { mode = mode, srow = sr, scol = sc, erow = er, ecol = ec }
    end
  end
end

-- Find the innermost single-line block enclosing `pos` (defaults to cursor) and
-- return its breakpoint-injection action, or nil to use the new-line fallback.
function M.inline_target(bufnr, pos)
  local ok, node = pcall(vim.treesitter.get_node, { bufnr = bufnr, pos = pos })
  if not ok or not node then return nil end
  while node do
    if blocks[node:type()] then
      local sr, _, er, _ = node:range()
      if sr == er then -- single line only; multi-line blocks use the fallback
        local action = resolve(node, bufnr)
        if action then return action end
      end
    end
    node = node:parent()
  end
  return nil
end

local function insert_breakpoint()
  local ft = vim.bo.filetype
  local snippet = breakpoints[ft]
  if not snippet then
    vim.notify('No breakpoint for filetype: ' .. (ft == '' and 'none' or ft), vim.log.levels.WARN)
    return
  end

  local action = M.inline_target(0)
  if action then
    local inline = snippet:gsub(';%s*$', '') .. '; ' -- strip trailing ';' so debugger; stays single
    if action.mode == 'wrap' then
      vim.api.nvim_buf_set_text(0, action.erow, action.ecol, action.erow, action.ecol, { ')' })
      vim.api.nvim_buf_set_text(0, action.srow, action.scol, action.srow, action.scol, { '(' .. inline })
    else
      vim.api.nvim_buf_set_text(0, action.row, action.col, action.row, action.col, { inline })
    end
    vim.cmd.write()
    return
  end

  -- fallback: open a new line below and insert the plain breakpoint
  local keys = 'o' .. snippet .. vim.api.nvim_replace_termcodes('<Esc>:w<CR>', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

local opts = { noremap = true, silent = true, desc = 'Insert language-aware breakpoint' }
vim.keymap.set('n', '<Leader>p', insert_breakpoint, opts)
vim.keymap.set('n', '<Leader>o', insert_breakpoint, opts)

return M
