" for plug
set nocompatible
filetype off

" auto install Plug https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""" plugins
call plug#begin('~/.config/nvim/plugged')
" main plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocompletion
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search (will be installed system-wide)
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep' " search by files content
Plug 'scrooloose/nerdtree' " file explorer
Plug 'Xuyuanp/nerdtree-git-plugin' " git extension for NERDTree
Plug 'tpope/vim-fugitive' " git integration
Plug 'scrooloose/nerdcommenter' " simpler comments
Plug 'tpope/vim-repeat' " repeat plugin commands with '.'
Plug 'tpope/vim-surround' " simple quoting and parenthesizing
Plug 'vim-scripts/auto-pairs-gentle' " auto closing brackets
Plug 'tpope/vim-endwise' " auto 'end' keyword
Plug 'drzel/vim-scrolloff-fraction' " auto scroll when getting closer to window border
Plug 'thoughtbot/vim-rspec' " RSpec integration
Plug 'airblade/vim-gitgutter' " git status near line numbers
Plug 'simeji/winresizer' " easier split resizing

" language and tools syntax support
Plug 'pangloss/vim-javascript' " JavaScript
Plug 'mxw/vim-jsx' " react
Plug 'posva/vim-vue' " vue
Plug 'jparise/vim-graphql' " graphQL
Plug 'elixir-editors/vim-elixir' " elixir
Plug 'vim-ruby/vim-ruby' " ruby
Plug 'styled-components/vim-styled-components', { 'branch': 'main' } " CSS in JS files
Plug 'tpope/vim-rails' " rails
Plug 'ap/vim-css-color' " colors preview

" styling
Plug 'jacoborus/tender.vim' " colorscheme
"Plug 'morhetz/gruvbox' " colorscheme without true color support
Plug 'itchyny/lightline.vim' " statusline
Plug 'ryanoasis/vim-devicons' " icons, should be last in this list
call plug#end()
" TODO plugins to outer source
" TODO snippets

""" colors and highlighting
set background=dark " for correct colors in tmux
set t_Co=256 " use 265 colors
if exists('+termguicolors') " enable true color
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
syntax on " enable syntax highlighting
colorscheme tender " set colorscheme
" syntax highlighting for specific file types
autocmd BufReadPost .{jscs,jshint,eslint}rc set filetype=json
autocmd BufReadPost .profile                set filetype=zsh
autocmd BufReadPost .gemrc                  set filetype=yaml
autocmd BufReadPost Dockerfile.*            set filetype=dockerfile
autocmd BufReadPost .vimrc.*                set filetype=vim
" TODO js.haml js.erb

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
    \   'colorscheme': 'tender',
    \   'subseparator': { 'left': '', 'right': '' },
    \   'separator': { 'left': '', 'right': '' }
    \ }
" add icon to file format
function! FileTypeWithIcon()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'plain') : ''
endfunction
" add icon to file format
function! FileFormatWithIcon()
  return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol() . ' ' . &fileformat) : ''
endfunction
" filename with modified sign and without separator
function! FileNameWithModifiedSign()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' [+]' : ''
  return filename . modified
endfunction

""" cursor
set cursorline " shows cursorline
set number " shows current line number
set relativenumber " shows relative numbers
" visual selection color
highlight Visual guibg=#124A2C
" default colors for cursorline
highlight CursorLine guibg=#323D3E
highlight Cursor guibg=#00AAFF
" change color when entering insert mode
autocmd InsertEnter * highlight CursorLine guibg=#3E3D32
autocmd InsertEnter * highlight Cursor guibg=#A6E22E
" revert color to default when leaving insert mode
autocmd InsertLeave * highlight CursorLine guibg=#323D3E
autocmd InsertLeave * highlight Cursor guibg=#00AAFF

""" search
set hlsearch " highlights search items
set incsearch " highligths search items dynamically as they are typed
set ignorecase " the case of normal letters is ignored
set smartcase " overrides ignorecase if search contains uppercase chars
set path+=** " allows gf to look deep into folders during search
set tags=./.git/tags " for ctags
" // in visual mode to search selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" do not search in file names and line numbers, only contents; change match color to red
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4.. --color hl:#ff8787,hl+:#ff0000'}, <bang>0)
" ctrl + g to RipGrep files
nnoremap <C-g> :Ag<Cr>
" ctrl + p to fuzzy search files
nnoremap <C-p> :FZF<Cr>

""" tabbing and indenting
set nowrap " don't wrap lines
set tabstop=2 " tab to two spaces
set shiftwidth=2 " identation in normal mode pressing < or >
set softtabstop=2 " set 'tab' as 2 spaces and removes 2 spaces on backspace
set expandtab " replaces tabs with spaces
set smarttab " use shiftwidth instead of tabstop at start of lines
set autoindent " copy indent from current line when starting a new line
set smartindent " does smart autoindenting in C-like code

""" folding
set nofoldenable " don't fold by default
set foldmethod=syntax " fold based on syntax
set foldnestmax=3 " deepest fold is 3 levels

""" external files
set nowritebackup " do not write backup before save
set autoread " to autoread if file was changed outside from vim
set noswapfile " do not use swap files
set nobackup " to not write backup during overwriting file
" allows vimrc if repo is trusted by creating .git/safe directory
if filereadable(".git/safe/../../vimrc.local")
  source .git/safe/../../.vimrc.local
endif

""" viewport and messages
set encoding=utf-8 " viewport default encodyng
set listchars=tab:▸\ ,eol:¬,trail:∙ " shows hidden end of line. tabs and trailing spaces
set list " enables showing of hidden chars
set shortmess+=c " do not show ins=completion-menu messages
set shortmess+=s " do not show 'search hit BOTTOM' messages
set showcmd " shows commands in last line
set colorcolumn=121 " vertical line on 121'st column
" auto scroll on 20% of window width
let g:scrolloff_fraction = 0.2

""" buffers
set hidden " do not close buffer when window closed

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
" do not allow arrows in normal and visual modes
nnoremap <Left> :echoe " Nope, use h "<CR>
nnoremap <Right> :echoe " Nope, use l "<CR>
nnoremap <Up> :echoe " Nope, use k "<CR>
nnoremap <Down> :echoe " Nope, use j "<CR>
vnoremap <Left> :echoe " Nope, use h "<CR>
vnoremap <Right> :echoe " Nope, use l "<CR>
vnoremap <Up> :echoe " Nope, use k "<CR>
vnoremap <Down> :echoe " Nope, use j "<CR>
" clear search buffer
nnoremap <C-x> :let @/ = ""<CR>
" redraw and reload configuration
command! Reload source $MYVIMRC | redraw!
" Q to exit
command! Q q
" edit vimrc
command! Vimrc :edit $MYVIMRC
" plug aliases
command! Pi :PlugInstall
command! Pu :PlugUpdate
" TODO ctags

""" text
" enable auto-pairs
let g:AutoPairsUseInsertedCount = 1
set updatetime=100 " update faser
" use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
nnoremap <C-d> :tabclose<CR>
" TODO return tab colors

""" git
set diffopt+=vertical " forse to use vertical split for diff
" git and fugitive aliases
command! Gst :Gstatus
command! Gd :Gdiff
command! Gcm :Gcommit
command! Gca :Gcommit --amend
command! Gcan :Gcommit --amend --no-edit
" Take changes by fugitive's Gread and close splits
command! Take :Gread | wq | q
let g:NERDTreeShowIgnoredStatus = 1 " show ignored status in nerdtree, a heavy feature may cost much more time
let g:gitgutter_max_signs = 1000 " increase max displayed signs for gitgutter

""" file explorer
" run NERDTree when vim started with no specified files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI = 1 " remove helper from ui
let NERDTreeAutoDeleteBuffer = 1 "delete buffer of deleted file
let NERDTreeQuitOnOpen = 2 " close NERDTree on file open
let NERDTreeShowHidden = 1 " show hidden files by default
let NERDTreeShowBookmarks = 1 " show bookmarks by default
" ctrl + n to toggle file explorer and update it
map <C-n> :NERDTreeToggle <bar> :NERDTreeRefreshRoot<CR>

""" RSpec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
