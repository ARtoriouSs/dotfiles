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

-- macros
vim.fn.setreg('p', [[Abinding.pry:w]])            -- insert a pry breakpoint on the new line
vim.fn.setreg('o', [[If{€ý5a binding.pry;;w]]) -- insert a pry breakpoint in the begnning of a { } block
