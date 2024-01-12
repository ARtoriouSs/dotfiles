vim.opt.diffopt = vim.opt.diffopt + "vertical" -- vertical diff

-- git and Fugitive aliases
vim.api.nvim_create_user_command('Gst', ':Git', {bang = true})
vim.api.nvim_create_user_command('Gd', ':Gdiff', {bang = true})
vim.api.nvim_create_user_command('Gds', ':Gdiffsplit!', {bang = true})
vim.api.nvim_create_user_command('Gb', ':Git blame', {bang = true})
vim.api.nvim_create_user_command('Gcm', ':Git commit', {bang = true})
vim.api.nvim_create_user_command('Gca', ':Git commit --amend', {bang = true})
vim.api.nvim_create_user_command('Gcan', ':Git commit --amend --no-edit', {bang = true})
vim.api.nvim_create_user_command('Gl', ':Commits', {bang = true})
vim.api.nvim_create_user_command('Take', ':Gread | wq | q', {bang = true}) -- take changes by fugitive's Gread and close splits
vim.api.nvim_create_user_command('Add', ":Git add % | silent exec '!status-beside'", {bang = true}) -- git add and show status in tmux pane beside
vim.api.nvim_create_user_command('Reset', ":Git checkout -- % | silent exec '!status-beside'", {bang = true}) -- resets current file to HEAD
