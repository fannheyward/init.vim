set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'honza/vim-snippets'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
"Bundle 'garbas/vim-snipmate'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/taglist.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
Bundle 'vim-scripts/TaskList.vim'
" vim-scripts repos
"Bundle 'a.vim'

filetype plugin indent on     " required! 
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set mapleader
"let mapleader = ","
map <silent> <leader>ss :source ~/.vimrc<cr>
map <silent> <leader>ee :e ~/.vimrc<cr>
map <silent> <leader>n :noh<cr>

set guifont=Monaco:h15
set guifontwide=Monaco:h15
colorscheme solarized
set background=dark
set laststatus=2
set ruler

" Chinese encodingcoding
set encoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1
set fileencoding=utf-8

"set undofile
"set undodir=~/.undodir
"set undolevels=1000

set number
setlocal noswapfile
" tab
set autoindent        "always set autoindenting on
set smartindent       "set smart indent
set smarttab          "use tabs at the start of a line, spaces elsewhere
set expandtab
set tabstop=4
set shiftwidth=4
set wildmenu
"set foldmethod=indent
set showmatch
set mat=2
set matchpairs+=<:>
syntax on
set hlsearch
set ignorecase smartcase incsearch 
set completeopt=longest,menu
set backspace=indent,eol,start
let do_syntax_sel_menu=1
set ut=200

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Plugin config.
" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*/nginx_runtime/*,*/build/*,*/logs/*,*/data/*

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" TagList
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:Tlist_Inc_Winwidth=0
let g:Tlist_Use_Right_Window=1
"let g:Tlist_Auto_Open=1
let g:Tlist_Show_One_File=1
"let g:Tlist_Compact_Format=1
"let g:Tlist_Enable_Fold_Column=0

" Tasklist
let g:tlTokenList = ['TODO' , 'WTF', 'FIX']

" neocomplcache.vim
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
let g:NeoComplCache_DisableAutoComplete = 0
let g:neocomplcache_enable_auto_select = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

