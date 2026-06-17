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

-- <Leader>p: insert a breakpoint matching the buffer's language, then save
local breakpoints = {
  ruby = 'binding.pry',
  javascript = 'debugger;',
  javascriptreact = 'debugger;',
  typescript = 'debugger;',
  typescriptreact = 'debugger;',
  elixir = 'require IEx; IEx.pry',
}
vim.keymap.set('n', '<Leader>p', function()
  local snippet = breakpoints[vim.bo.filetype]
  if not snippet then
    vim.notify('No breakpoint for filetype: ' .. (vim.bo.filetype == '' and 'none' or vim.bo.filetype), vim.log.levels.WARN)
    return
  end
  local keys = 'o' .. snippet .. vim.api.nvim_replace_termcodes('<Esc>:w<CR>', true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end, { noremap = true, silent = true, desc = 'Insert language-aware breakpoint' })
