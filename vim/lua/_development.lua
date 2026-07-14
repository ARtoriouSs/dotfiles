-- run dev commands in beside tmux pane
vim.api.nvim_create_user_command('Spec', "silent exec '!run-beside spec\\ ' . expand('%')", { bang = true })
vim.api.nvim_create_user_command('SPec', 'Spec', { bang = true })
vim.api.nvim_create_user_command('Specl', "silent exec '!run-beside spec\\ ' . expand('%') . ':' . line('.')", { bang = true })
vim.api.nvim_create_user_command('SPecl', 'Specl', { bang = true })
vim.api.nvim_create_user_command('Speca', "silent exec '!run-beside spec'", { bang = true })
vim.api.nvim_create_user_command('SPeca', 'Speca', { bang = true })
vim.api.nvim_create_user_command('Deps', "silent exec '!run-beside deps'", { bang = true })

vim.api.nvim_create_user_command('Cs', 'let @+ = "spec " . expand(\'%\')', { bang = true }) -- copy 'spec path/to/current/file'
vim.api.nvim_create_user_command('Csl', 'let @+ = "spec " . expand(\'%\') . \':\' . line(".")', { bang = true }) -- copy 'spec path/to/current/file:cursor_line'

vim.api.nvim_create_user_command('Exec', "silent exec '!run-beside ruby\\ ' . expand('%')", { bang = true }) -- run current ruby file

vim.api.nvim_create_user_command('Rcop', "silent exec '!run-beside rcop'", { bang = true }) -- run rubocop for all changed files
vim.api.nvim_create_user_command('Rcopl', "silent exec '!run-beside bundle\\ exec\\ rubocop\\ ' . expand('%')", { bang = true }) -- run rubocop for current file

vim.api.nvim_create_user_command("Migr", function() -- open last migration file
  local migration = vim.fn.system("last-migration"):gsub("%s+$", "")
  if migration:find("No such file or directory") or not migration or migration == "" then
    vim.notify("No migration found", vim.log.levels.WARN)
  else
    vim.cmd("edit " .. vim.fn.fnameescape(migration))
  end
end, {})
vim.api.nvim_create_user_command('MIgr', 'Migr', { bang = true })

-- Reformat Ruby hash: {:foo=>"bar"} -> { foo: "bar" },
-- one key per line when the result is longer than 120 chars. Uses syntax_tree (stree),
-- which handles rocket->colon, nesting, spacing and line wrapping.
vim.api.nvim_create_user_command('Rhash', function(opts)
  local line1, line2 = opts.line1, opts.line2

  if opts.range == 0 then -- no range: select whole enclosing hash from anywhere inside it
    while vim.fn.searchpair('{', '', '}', 'bW') > 0 do end -- climb to outermost enclosing '{'
    if vim.fn.search('{', 'cW') > 0 then                   -- land on it (or next '{' if not inside)
      line1 = vim.fn.line('.')
      vim.cmd('normal! %')
      line2 = vim.fn.line('.')
    end
  end

  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
  local out = vim.fn.systemlist({ 'stree', 'format', '--print-width=120' }, table.concat(lines, '\n'))

  if vim.v.shell_error ~= 0 then
    vim.notify(table.concat(out, '\n'), vim.log.levels.ERROR)
    return
  end

  local indent = lines[1]:match('^%s*') -- stree formats from column 0; restore leading indent
  if indent ~= '' then
    for i, l in ipairs(out) do out[i] = indent .. l end
  end

  vim.api.nvim_buf_set_lines(0, line1 - 1, line2, false, out)
end, { range = true, desc = 'Reformat Ruby hash (via stree)' })

-- Interactive shell is needed to load helpers, however jq outputs ZLE error in interactive mode,
-- so drop -i just for this run. Simpler version just incase:
-- vim.api.nvim_create_user_command('Jq', ':%!jq .', { bang = true }) -- format JSON
vim.api.nvim_create_user_command("Jq", function(opts)
  local shellcmdflag = vim.o.shellcmdflag
  vim.o.shellcmdflag = "-c" -- drop the -i just for this run
  local ok = pcall(vim.cmd, string.format([[%d,%d!jq .]], opts.line1, opts.line2))
  vim.o.shellcmdflag = shellcmdflag
  if ok then vim.cmd("Json") end
end, { range = true, desc = 'Format JSON using jq' })

vim.api.nvim_create_user_command('Xq', function(opts)
  local shellcmdflag = vim.o.shellcmdflag
  vim.o.shellcmdflag = "-c" -- drop the -i just for this run
  pcall(vim.cmd, string.format([[%d,%d!tidy -xml -i -q]], opts.line1, opts.line2))
  vim.o.shellcmdflag = shellcmdflag
end, { range = true, desc = 'Format XML using tidy' })

for _, name in ipairs({ "JJ", "Jj" }) do -- JJ/Jj = Jq + JSON
  vim.api.nvim_create_user_command(name, function()
    vim.cmd("Jq")
    vim.cmd("JSON")
  end, {})
end

for _, name in ipairs({ "XX", "Xx" }) do -- XX/Xx = Xq + XML
  vim.api.nvim_create_user_command(name, function()
    vim.cmd("Xq")
    vim.cmd("XML")
  end, {})
end

-- commenting
require('Comment').setup({
  padding = true,

  -- normal mode mappings
  toggler = {
    line = '<leader>c',
    block = '<leader>bc',
  },

  -- visual modes mappings
  opleader = {
    line = '<leader>c',
    block = '<leader>bc',
  },
})

-- <Leader>p language-aware breakpoint inserter
require('_development_breakpoints')
