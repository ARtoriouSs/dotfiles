" all plugins and plugin-related configurations sourced here
" this is needed because vim becomes critically broken when loads
" vimrc without plugins installed, so with this file it's possible
" to load only plugins without the rest of configuration

" auto install Plug
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
Plug 'junegunn/fzf.vim' " vim plugin for fzf
Plug 'jremmen/vim-ripgrep' " search by files content
Plug 'scrooloose/nerdtree' " file explorer
Plug 'Xuyuanp/nerdtree-git-plugin' " git extension for NERDTree
Plug 'tpope/vim-fugitive' " git integration
Plug 'scrooloose/nerdcommenter' " simpler comments
Plug 'tpope/vim-repeat' " repeat plugin commands with '.'
Plug 'tpope/vim-surround' " simple quoting and parenthesizing
Plug 'ludovicchabant/vim-gutentags' " autoupdate ctags on file save
Plug 'tree-sitter/tree-sitter' " language parser
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " nvim support for tree-sitter

" helpers
Plug 'RRethy/nvim-treesitter-endwise' " auto 'end' keyword
Plug 'drzel/vim-scrolloff-fraction' " auto scroll when getting closer to window border
Plug 'airblade/vim-gitgutter' " git status near line numbers
Plug 'simeji/winresizer' " easier split resizing
Plug 'tpope/vim-eunuch' " shell file commands
Plug 'chaoren/vim-wordmotion' " navigation between parts of snake_case and CamelCase words

" languages and tools support
Plug 'vim-ruby/vim-ruby' " ruby
Plug 'elixir-editors/vim-elixir' " elixir
Plug 'pangloss/vim-javascript' " JavaScript
Plug 'tpope/vim-rails' " rails
Plug 'mxw/vim-jsx' " react
Plug 'leafgarland/typescript-vim' " typescript
Plug 'peitalin/vim-jsx-typescript' " react with typescrypt
Plug 'posva/vim-vue' " vue
Plug 'styled-components/vim-styled-components', { 'branch': 'main' } " CSS in JS files
Plug 'kchmck/vim-coffee-script' " coffee script
Plug 'ap/vim-css-color' " colors preview
Plug 'othree/html5.vim' " html
Plug 'vim-scripts/HTML-AutoCloseTag' " auto-closing html tags
Plug 'tpope/vim-bundler' " bundler
Plug 'slim-template/vim-slim' " slim templates
Plug 'jparise/vim-graphql' " graphQL
Plug 'chr4/nginx.vim' " nginx
Plug 'gisphm/vim-gitignore' " gitignore
Plug 'JamshedVesuna/vim-markdown-preview' " markdown preview in a browser

" styling
Plug 'morhetz/gruvbox' " colorscheme
Plug 'itchyny/lightline.vim' " statusline
Plug 'ryanoasis/vim-devicons' " icons, should be last in this list
call plug#end()
