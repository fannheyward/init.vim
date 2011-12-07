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
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'wincent/Command-T'
"Bundle 'fholgado/minibufexpl.vim'
Bundle 'vim-scripts/mru.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/statusline.vim'
" vim-scripts repos
Bundle 'L9'
Bundle 'AutoComplPop'
Bundle 'a.vim'

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
let mapleader = ","
map <silent> <leader>ss :source ~/.vimrc<cr>
map <silent> <leader>ee :e ~/.vimrc<cr>
map <silent> <leader>n :noh<cr>

set guifont=Monaco:h15
set guifontwide=Monaco:h15
colorscheme slate

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
" TagList
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:Tlist_Inc_Winwidth=0
let g:Tlist_Use_Right_Window=1
"let g:Tlist_Auto_Open=1
let g:Tlist_Show_One_File=1
"let g:Tlist_Compact_Format=1
"let g:Tlist_Enable_Fold_Column=0

" Tasklist
let g:tlTokenList = ['TODO' , 'WTF']

" acp.vim
let g:acp_behaviorPythonOmniLength = -1

" BufExplorer
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber

