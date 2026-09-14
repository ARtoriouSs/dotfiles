local treesitter = require('nvim-treesitter')

-- parsers and queries go to stdpath('data')/site, which nvim-treesitter prepends to runtimepath
treesitter.setup {}

-- installed asynchronously; a no-op for parsers that are already present
treesitter.install {
  'bash',
  'diff',
  'pem',

  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',

  'csv',
  'json', -- also used for the jsonc filetype, which has no parser of its own
  'xml',
  'yaml',
  'proto',

  'ruby',
  'elixir',
  'javascript',
  'typescript',
  'tsx',
  'lua',
  'c',
  'cpp',
  'make',
  'embedded_template', -- template engines like erb and ejs
  'html',
  'sql',
  'vim',
  'vimdoc',
  'dockerfile',
  'terraform',
  'kdl',
  'latex',
  'markdown',
}

-- disable slow treesitter highlighting for large files
local function too_large_to_highlight(buf)
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  -- fs_stat misses fugitive/scratch/unwritten buffers (e.g. the HEAD side of :Gdiffsplit)
  -- which have no on-disk path; fall back to the loaded byte size
  local size = (ok and stats and stats.size)
    or vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
  return size > max_filesize
end

-- the plugin's `main` branch dropped the module system, so every feature is enabled by hand
local function enable_treesitter(buf, lang)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end

  -- highlighting, provided by neovim itself; throws for languages that ship no highlights query
  if not too_large_to_highlight(buf) then
    pcall(vim.treesitter.start, buf, lang)
  end

  -- indentation, provided by the plugin and still marked experimental upstream;
  -- languages without an indents query keep their native indentexpr
  if vim.treesitter.query.get(lang, 'indents') then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local install_attempted = {}

-- replacement for the old `auto_install`: fetch a parser the first time its filetype shows up
local function install_and_enable(buf, lang)
  if install_attempted[lang] or not vim.list_contains(treesitter.get_available(), lang) then
    return
  end
  install_attempted[lang] = true

  treesitter.install(lang):await(function(err)
    if err then
      return
    end
    vim.schedule(function()
      enable_treesitter(buf, lang)
    end)
  end)
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang then
      return
    end

    if vim.treesitter.language.add(lang) then
      enable_treesitter(args.buf, lang)
    else
      install_and_enable(args.buf, lang)
    end
  end,
})

-- nvim-treesitter-endwise registers its `endwise!` directive for the pre-0.12 match shape,
-- where a capture held a single node rather than a list of nodes; without this its heredoc
-- and vimscript-function patterns error out on <CR>. Required until upstream migrates.
require('nvim-treesitter.endwise') -- load it here so this registration is the last one
vim.treesitter.query.add_directive('endwise!', function(match, _, _, predicate, metadata)
  local suffix = match[predicate[3]]

  metadata.endwise_end_text = predicate[2]
  metadata.endwise_end_suffix = type(suffix) == 'table' and suffix[#suffix] or suffix
  metadata.endwise_end_node_type = predicate[4]
  metadata.endwise_shiftcount = predicate[5] or 1
  metadata.endwise_end_suffix_pattern = predicate[6] or '^.*$'
end, { force = true })
