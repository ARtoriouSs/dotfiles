set shellcmdflag=-ic " run shell in interactive mode to load functions and aliases from the shell config
set nocompatible " disables vi compatibility (default in neovim, for vim only), should be on the top

" plugins moved to another file to be able to sourse them without the rest of configuration
source ~/dotfiles/vim/plugins.vim

lua require('treesitter')

""" statusline settings
set laststatus=2 " shows status line for all splits
let g:lightline = {
    \   'active': {
    \     'left': [
    \       [ 'mode', 'paste' ],
    \       [ 'bufnum', 'readonly' ],
    \       [ 'filename' ]
    \     ],
    \   },
    \   'inactive': {
    \     'left': [
    \       [ 'bufnum' ],
    \       [ 'filename' ]
    \     ]
    \   },
    \   'component_function': {
    \     'filetype': 'FileTypeWithIcon',
    \     'fileformat': 'FileFormatWithIcon',
    \     'filename': 'FileNameWithModifiedSign'
    \   },
    \   'colorscheme': 'gruvbox',
    \   'subseparator': { 'left': '', 'right': '' },
    \   'separator': { 'left': '', 'right': '' }
    \ }
" add icon to file format
function! FileTypeWithIcon()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'plain') : ''
endfunction
" add icon to file format
function! FileFormatWithIcon()
  return winwidth(0) > 70 ? WebDevIconsGetFileFormatSymbol() : ''
endfunction
" filename with modified sign and without separator
function! FileNameWithModifiedSign()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' [+]' : ''
  return filename . modified
endfunction


""" colors and highlighting
set background=dark " for correct colors in tmux
set t_Co=256 " use 265 colors
if exists('+termguicolors') " enable true color
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
syntax on " enable syntax highlighting
colorscheme gruvbox " set colorscheme
" syntax highlighting for specific file types
autocmd BufNewFile,BufReadPost .{jscs,jshint,eslint}rc      set filetype=json
autocmd BufNewFile,BufReadPost coc-settings.json            set filetype=jsonc
autocmd BufNewFile,BufReadPost {.profile,*.zsh-theme}       set filetype=zsh
autocmd BufNewFile,BufReadPost .gemrc                       set filetype=yaml
autocmd BufNewFile,BufReadPost Dockerfile.*                 set filetype=dockerfile
autocmd BufNewFile,BufReadPost .vimrc.*                     set filetype=vim
autocmd BufNewFile,BufReadPost *.js.{erb,haml,slim}         set filetype=javascript
autocmd BufNewFile,BufReadPost *.jsx                        set filetype=javascript.jsx
autocmd BufNewFile,BufReadPost .env.*                       set filetype=sh
autocmd BufNewFile,BufReadPost *.inky                       set filetype=eruby
autocmd BufNewFile,BufReadPost Procfile                     set filetype=sh
" highlight trailing spaces to clearly see indentation
highlight TrailingSpace guifg=red
match TrailingSpace / \+$/
" change selected tab color
let s:palette = g:lightline#colorscheme#gruvbox#palette " <- theme palette
let s:palette.tabline.tabsel = [ [ '#-000001', '#71a126', 16, 81 ] ]
unlet s:palette
highlight CursorLine guibg=#38351d
autocmd InsertEnter * highlight CursorLine guibg=#2E3D32
autocmd InsertLeave * highlight CursorLine guibg=#38352d
" filetype aliases
command! Ruby :set filetype=ruby
command! Elixir :set filetype=elixir
command! Js :set filetype=javascript
command! JS :set filetype=javascript
command! Sql :set filetype=sql
command! SQL :set filetype=sql
command! Json :set filetype=json
command! JSON :set filetype=json


""" cursor
set cursorline " shows cursorline
set number " shows current line number
set relativenumber " shows relative numbers


""" system
command! Again silent exec '!last-command-beside'


""" search
set hlsearch " highlights search items
set incsearch " highligths search items dynamically as they are typed
set ignorecase " the case of normal letters is ignored
set smartcase " overrides ignorecase if search contains uppercase chars
set path+=** " allows gf to look deep into folders during search
set tags^=.git/tags;$PROJECTS " path to ctags file, stop seatching on $PROJECTS directory
" // in visual mode to search selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" search in both content, file names and line numbers
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--color hl:#ff8787,hl+:#ff0000'}, <bang>0)
" do not search in file names and line numbers, only contents
command! -bang -nargs=* Agc call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4.. --color hl:#ff8787,hl+:#ff0000'}, <bang>0)
" search in current buffer
command! -bang -nargs=* Agb call fzf#vim#buffer_lines(<q-args>, {'options': '--color hl:#ff8787,hl+:#ff0000'}, <bang>0)
" ctrl + g to fuzzy search files
nnoremap <C-g> :Agc<Cr>
" ctrl + c to fuzzy search current buffer
nnoremap <C-c> :Agb<Cr>
" ctrl + p to fuzzy search file names
nnoremap <C-p> :FZF<Cr>
" ctrl + b to search in history
nnoremap <C-b> :History<Cr>
" ctags
let g:gutentags_ctags_tagfile=".git/tags" " tags file for gutentags
let g:gutentags_resolve_symlinks=1 " generate tags for original file's project if editing symlink

""" tabs and indentation
set nowrap " don't wrap lines
set tabstop=2 " tab to two spaces
set shiftwidth=2 " identation in normal mode pressing < or >
set softtabstop=2 " set 'tab' as 2 spaces and removes 2 spaces on backspace
set expandtab " replaces tabs with spaces
set smarttab " use shiftwidth instead of tabstop at start of lines
set autoindent " copy indent from current line when starting a new line
set smartindent " does smart autoindenting in C-like code
" make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv


""" folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
set nofoldenable " don't fold by default


""" files
set nowritebackup " do not write backup before save
set autoread " to autoread if file was changed outside from vim
set noswapfile " do not use swap files
set nobackup " to not write backup during overwriting file


""" viewport and messages
set encoding=utf-8 " viewport default encodyng
set listchars=tab:▸\ ,eol:¬,trail:∙ " shows hidden end of line. tabs and trailing spaces
set list " enables showing of hidden chars
set shortmess+=c " do not show ins=completion-menu messages
set shortmess+=s " do not show 'search hit BOTTOM' messages
set showcmd " shows commands in last line
set colorcolumn=121 " vertical line on 121'st column
set signcolumn=yes " sign column, `number` to be single width
" auto scroll on 20% of window width
let g:scrolloff_fraction = 0.2
let vim_markdown_preview_hotkey='<Leader>m' " toggle markdown preview
let vim_markdown_preview_browser='Google Chrome' " use Google Chrome for markdown preview


""" buffers and copying
set hidden " do not close buffer when window is closed
" use alt + d to delete without copying
nnoremap <M-d> "_d
xnoremap <M-d> "_d
" use alt + p in visual mode to pase without copying selection
xnoremap <M-p> "_dP


""" controls and navigation
set timeoutlen=250 " mapping delay
set clipboard=unnamedplus " use system clipboard by default if no register specified
set wildmenu " autocompletion using TAB
set mouse=a " enable mouse support
autocmd BufWritePre * %s/\s\+$//e "removes trailing whitespaces
autocmd BufNewFile * set noeol "removes eol
" command without shift
nnoremap ; :
vnoremap ; :
" remove Ex mode mapping
nnoremap Q <nop>
" clear search buffer
nnoremap <C-x> :let @/ = ""<CR>
command! Reload source $MYVIMRC | redraw! " redraw and reload configuration
command! Q q " Q to exit
" edit vimrc and plugins in dotfiles dir (not $MYVIMRC) to have access to git inside vim (symlinked to $MYVIMRC)
command! Vimrc :edit $DOTFILES_VIM/.vimrc
command! Vimrcl :edit .vimrc.local " edit local vimrc
command! Plugins :edit $DOTFILES_VIM/plugins.vim
" edit todo files
command! Todo :edit $HOME/todo.yml
command! Todol :edit todo.yml
" plug aliases
command! Pi :PlugInstall
command! Pu :PlugUpdate
command! Cc let @+ = expand('%') " copy path to current file
command! Ccl let @+ = expand('%') . ':' . line(".") " copy 'path/to/current/file:cursor_line'
" use alt + w/e/b to navigate by word parts
let g:wordmotion_mappings = {
\ 'w' : '<M-w>',
\ 'b' : '<M-b>',
\ 'e' : '<M-e>'
\ }
" prettify json in current buffer
command! Jq :%!jq .


""" text
set updatetime=100 " update faser
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

""" splits
set splitbelow " open new horizontal split below
set splitright " open new vertical split to the right
" easier split navigation ctrl + h/j/k/l
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>


""" tabs
nnoremap <C-a> :tabprevious<CR>
nnoremap <C-s> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-q> :tabclose<CR>


""" git
if has('nvim')
  set diffopt+=vertical " forse to use vertical split for diff
endif
" git and fugitive aliases
command! Gst :Git
command! Gd :Gdiff
command! Gds :Gdiffsplit!
command! Gb :Git blame
command! Gcm :Git commit
command! Gca :Git commit --amend
command! Gcan :Git commit --amend --no-edit
command! Gl :Commits
command! Take :Gread | wq | q " Take changes by fugitive's Gread and close splits
" git add and show status in tmux pane beside
command! Add :Git add % | silent exec '!status-beside'
let g:gitgutter_max_signs = 1000 " increase max displayed signs for gitgutter


""" file explorer
" run NERDTree when vim started with specified directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
let NERDTreeMinimalUI = 1 " remove helper from ui
let NERDTreeAutoDeleteBuffer = 1 "delete buffer of deleted file
let NERDTreeShowHidden = 1 " show hidden files by default
let NERDTreeShowBookmarks = 1 " show bookmarks by default
let g:NERDTreeGitStatusShowIgnored = 1 " show ignored status in nerdtree, a heavy feature may cost much more time
" ctrl + n to toggle file explorer and update it
map <C-n> :NERDTreeToggle <bar> :NERDTreeRefreshRoot<CR>


""" Ruby
let @p = 'Abinding.pry:w' " macro to insert a breakpoint
let g:coc_global_extensions = ['coc-solargraph'] " Ruby language server, requires solargraph gem installed
command! Cs let @+ = "spec " . expand('%') " copy 'spec path/to/current/file'
command! Csl let @+ = "spec " . expand('%') . ':' . line(".") " copy 'spec path/to/current/file:cursor_line'
" run current spec file in beside tmux pane
command! Spec silent exec '!run-spec-beside ' . expand('%')
command! SPec Spec
command! Specl silent exec '!run-spec-beside ' . expand('%') . ':' . line(".")
command! SPecl Specl
command! Speca silent exec '!run-spec-beside'
command! SPeca Speca


""" should be last: allows vimrc if repo is trusted by creating .git/safe directory
if filereadable(".git/safe/../../.vimrc.local")
  source .git/safe/../../.vimrc.local
endif
if filereadable(".git/safe/../../.vimrc")
  source .git/safe/../../.vimrc
endif
