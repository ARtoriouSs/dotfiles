" for plug
set nocompatible
filetype off

" auto install Plug https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"*****************************
"********** plugins **********
"*****************************

call plug#begin('~/.config/nvim/plugged')
" main plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocompletion
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search (will be install system-wide)
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep' " search by files content
Plug 'scrooloose/nerdtree' " file explorer
Plug 'tpope/vim-fugitive' " git integration
Plug 'scrooloose/nerdcommenter' " simpler comments
Plug 'tpope/vim-repeat' " repeat plugin commands with '.'
Plug 'tpope/vim-surround' " simple quoting and parenthesizing
Plug 'jiangmiao/auto-pairs' " auto closing brackets
Plug 'tpope/vim-endwise' " auto end keyword
Plug 'drzel/vim-scrolloff-fraction' " auto scroll when getting closer to window border
Plug 'webdevel/tabulous' " better tab naming
Plug 'thoughtbot/vim-rspec' " RSpec integration

" language and tools syntax support
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jparise/vim-graphql'
Plug 'elixir-editors/vim-elixir'
Plug 'vim-ruby/vim-ruby'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' } " CSS in JS files
Plug 'tpope/vim-rails'
Plug 'ap/vim-css-color' " colors preview

" styling

call plug#end()

"*****************************
"********* mappings **********
"*****************************

" command without shift
nnoremap ; :
vnoremap ; :
" ctrl + g to RipGrep files
nnoremap <C-g> :Ag<Cr>
" ctrl + p to fuzzy search files
nnoremap <C-p> :FZF<Cr>
" ctrl + n to toggle file explorer
map <C-n> :NERDTreeToggle<CR>
" // in visual mode to search selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" tabs
nnoremap <C-a> :tabprevious<CR>
nnoremap <C-s> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-d> :tabclose<CR>
" easier split navigation ctrl + h/j/k/l
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>
" do not allow arrows in normal and visual modes
nnoremap <Left> :echoe " Nope, use h "<CR>
nnoremap <Right> :echoe " Nope, use l "<CR>
nnoremap <Up> :echoe " Nope, use k "<CR>
nnoremap <Down> :echoe " Nope, use j "<CR>
vnoremap <Left> :echoe " Nope, use h "<CR>
vnoremap <Right> :echoe " Nope, use l "<CR>
vnoremap <Up> :echoe " Nope, use k "<CR>
vnoremap <Down> :echoe " Nope, use j "<CR>
" RSpec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"*****************************
"********* commands **********
"*****************************

" rename tab
command! Rent :call g:tabulous#renameTab()
" redraw and reload configuration
command! Reload source $MYVIMRC | redraw!
" Q to exit
command! Q q
" edit vimrc
command! Vimrc :edit $MYVIMRC
" git and fugitive aliases
command! Gst :Gstatus
command! Gd :Gdiff
command! Gcm :Gcommit
command! Gca :Gcommit --amend
command! Gcan :Gcommit --amend --no-edit
" Take changes by fugitive's Gread and close splits
command! Take :Gread | wq | q

"*****************************
"********* settings **********
"*****************************

syntax on " enable syntax highlighting
colorscheme monokai " set colorscheme
set encoding=utf-8 " viewport default encodyng
set timeoutlen=250 " mapping delay
set cursorline " shows cursorline
set relativenumber " shows relative numbers
set number " shows current line number
set path+=** " allows find to look deep into folders during search
set wildmenu " autocompletion using TAB
set hidden " do not close buffer when window closed
set hlsearch " highlights search items
set incsearch " highligths search items dynamically as they are typed
set ignorecase " the case of normal letters is ignored
set smartcase " overrides ignorecase if search contains uppercase chars
set nowrap " don't wrap lines
set tabstop=2 " tab to two spaces
set shiftwidth=2 " identation in normal mode pressing < or >
set softtabstop=2 " set 'tab' as 2 spaces and removes 2 spaces on backspace
set expandtab " replaces tabs with spaces
set smarttab " use shiftwidth instead of tabstop at start of lines
set nofoldenable " don't fold by default
set foldmethod=syntax " fold based on syntax
set foldnestmax=3 " deepest fold is 3 levels
set autoindent " copy indent from current line when starting a new line
set smartindent " does smart autoindenting in C-like code
set nowritebackup " do not write backup before save
set autoread " to autoread if file was changed outside from vim
set noswapfile " do not use swap files
set nobackup " to not write backup during overwriting file
set showcmd " shows commands in last line
set list " enables showing of hidden chars
set listchars=tab:▸\ ,eol:¬,trail:∙ " shows hidden end of line. tabs and trailing spaces
set clipboard=unnamedplus " use system clipboard by default if no register specified
set diffopt+=vertical " forse to use vertical split for diff
set tags=./.git/tags " for ctags
set updatetime=300 " faster updating for coc.nvim
set shortmess+=c " do not show ins=completion-menu messages
set shortmess+=s " do not show 'search hit BOTTOM' messages

" more intuitive split opening
set splitbelow
set splitright

" status line default colors
highlight User1 ctermbg=202 ctermfg=16 cterm=bold
highlight StatusLine ctermbg=208 ctermfg=232 cterm=bold
highlight StatusLineNC ctermbg=8 cterm=bold

set laststatus=2 " shows status line for all splits
set statusline=%1*\ %3n\ %*%<\ %-.100f\ [%M][%H%R%W][%Y]\ %=%l:%-4c%-4P " statusline format

autocmd InsertEnter * highlight StatusLine ctermbg=5 ctermfg=15 cterm=bold
autocmd InsertEnter * highlight User1 ctermbg=129 ctermfg=15 cterm=bold
autocmd InsertLeave * highlight StatusLine term=reverse ctermbg=208 ctermfg=232 cterm=bold
autocmd InsertLeave * highlight User1 ctermbg=202 ctermfg=16 cterm=bold


" allows vimrc if repo is trusted by creating .git/safe directory
if filereadable(".git/safe/../../vimrc.local")
  source .git/safe/../../.vimrc.local
endif

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

autocmd BufWritePre * %s/\s\+$//e "removes trailing whitespaces
autocmd BufNewFile * set noeol "removes eol

" auto scroll on 20% of window width
let g:scrolloff_fraction = 0.2

" set syntax highlighting for specific file types
autocmd BufReadPost .{jscs,jshint,eslint}rc set filetype=json
autocmd BufReadPost .profile set filetype=zsh
autocmd BufReadPost .gemrc set filetype=yaml
autocmd BufReadPost Dockerfile.* set filetype=dockerfile
autocmd BufReadPost .vimrc.* set filetype=vim

"*****************************
"********** styling **********
"*****************************

let tabulousLabelNameDefault = 'untitled' " default tab name
let tabulousLabelModifiedStr = '* ' " modified tab marker
let tabulousLabelNumberStr = ') ' " string after label number
let tabulousLabelNameOptions = ':t' " tab label format: show only file name with extension
let tabulousCloseStr = '' " remove close symbol to the right of tabline

set colorcolumn=121 " vertical line on 121'st column

