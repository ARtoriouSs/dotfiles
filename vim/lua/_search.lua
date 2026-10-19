local telescope  = require('telescope')
local builtin    = require('telescope.builtin')
local previewers = require('telescope.previewers')
local from_entry = require('telescope.from_entry')

-- Smart previewer: chafa pixel art for images, bat/cat for code
local _img_exts = { png=1, jpg=1, jpeg=1, gif=1, bmp=1, webp=1, tiff=1, ico=1, avif=1 }
local function _is_image(path)
  local ext = path:match('%.([^%.]+)$')
  return ext and _img_exts[ext:lower()] ~= nil
end

local smart_previewer = previewers.new_buffer_previewer({
  title = 'Preview',
  get_buffer_by_name = function(_, entry)
    return from_entry.path(entry, false)
  end,
  define_preview = function(self, entry, status)
    local p = from_entry.path(entry, true)
    if not p or p == '' then return end

    if _is_image(p) and vim.fn.executable('chafa') == 1 then
      local bufnr = self.state.bufnr
      if vim.bo[bufnr].buftype == 'terminal' then return end

      local w = vim.api.nvim_win_get_width(self.state.winid)
      local h = vim.api.nvim_win_get_height(self.state.winid)

      vim.api.nvim_buf_call(bufnr, function()
        vim.fn.termopen({ 'chafa', '--size=' .. w .. 'x' .. h, p }, {
          on_exit = function(_, code)
            vim.defer_fn(function()
              if not vim.api.nvim_buf_is_valid(bufnr) then return end
            end, 100)
          end,
        })
      end)
    else
      require('telescope.config').values.buffer_previewer_maker(p, self.state.bufnr, {
        bufname = self.state.bufname,
        winid   = self.state.winid,
      })
    end
  end,
})

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous
      }
    }
  },

  pickers = {
    find_files = {
      find_command = {"rg", "--files", "--hidden", "--follow", "--glob", "!.git/*"}
    },

    live_grep = {
      additional_args = {"--hidden", "--sort-files", "--glob", "!.git/*", "--fixed-strings"}
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

vim.keymap.set('n', '<leader>f', function()
  -- cwd path relative to git root (e.g. "apps/api/"), empty at root or outside git
  local prefix = vim.fn.systemlist({ 'git', 'rev-parse', '--show-prefix' })[1] or ''
  if vim.v.shell_error ~= 0 then prefix = '' end

  -- line number from "path:112" or "path:112:5" suffix, used to jump after the file is opened
  local line_nr = nil

  builtin.find_files({
    previewer = smart_previewer, -- just remove if there's issues with previews

    -- ignore ":line" / ":line:col" suffix while filtering, but remember the line
    on_input_filter_cb = function(prompt)
      local path, line = prompt:match('^(.-):(%d+):%d+$')
      if not path then path, line = prompt:match('^(.-):(%d+)$') end
      line_nr = tonumber(line)
      return { prompt = path or prompt }
    end,

    -- function to normalize paths copied from terminal (because they break the search):
    -- removes leading "./", git diff "a/" / "b/" and git root prefix when nvim runs from a monorepo subdir
    -- default: vim.keymap.set('n', '<leader>f', builtin.find_files, {})
    attach_mappings = function(prompt_bufnr)
      local action_state = require('telescope.actions.state')
      local action_set = require('telescope.actions.set')
      -- jump to the remembered line (works for <CR>, <C-x>, <C-v> and <C-t>)
      action_set.select:enhance({
        post = function()
          if line_nr then
            local last = vim.api.nvim_buf_line_count(0)
            vim.api.nvim_win_set_cursor(0, { math.min(line_nr, last), 0 })
            vim.cmd('normal! zz')
          end
        end
      })
      local updating = false
      vim.api.nvim_create_autocmd("TextChangedI", {
        buffer = prompt_bufnr,
        callback = function()
          if updating then return end
          local picker = action_state.get_current_picker(prompt_bufnr)
          local prompt = picker:_get_prompt()
          local normalized = prompt
          if normalized:sub(1, 2) == "./" then
            normalized = normalized:sub(3)
          end
          if prefix ~= '' then
            local diff_side = normalized:sub(1, 2)
            if (diff_side == "a/" or diff_side == "b/") and normalized:sub(3, 2 + #prefix) == prefix then
              normalized = normalized:sub(3)
            end
            if normalized:sub(1, #prefix) == prefix then
              normalized = normalized:sub(#prefix + 1)
            end
          end
          if normalized ~= prompt then
            updating = true
            picker:set_prompt(normalized)
            updating = false
          end
        end
      })
      return true
    end
  })
end, {}) -- file search
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})  -- grep search
vim.keymap.set('n', '<leader>b', builtin.oldfiles,  {})  -- recently opened files search

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
