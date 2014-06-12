set nocompatible               " be iMproved

if has('vim_starting')
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'vim-scripts/TaskList.vim'
NeoBundle 'nacitar/a.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'fannheyward/rainbow_parentheses.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'vim-scripts/loremipsum'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'dyng/ctrlsf.vim'

filetype plugin indent on     " required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:snips_author = 'fannheyward'
let g:author = 'fannheyward'
let g:snips_email = 'fannheyward@gmail.com'
let g:email = 'fannheyward@gmail.com'
let g:snips_github = 'https://github.com/fannheyward'
let g:github = 'https://github.com/fannheyward'

:set timeout timeoutlen=1000 ttimeoutlen=10

" Set mapleader
"let mapleader = ","
map <silent> <leader>ss :source ~/.vimrc<cr>
map <silent> <leader>ee :e ~/.vimrc<cr>
map <silent> <leader>n :noh<cr>

nmap ? /\<\><Left><Left>

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
set scrolloff=2

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" some autocmd
au FileType json setlocal equalprg=python -mjson.tool
au FileType html,javascript,css setlocal shiftwidth=2 tabstop=2

:command W w
:command Q q
:command Qa qa
:command Wa wa
:command Wqa wqa
:command WQa wqa

" Plugin config.
" CtrlP
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

set wildignore+=*.pyc,*.sqlite,*.sqlite3
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/nginx_runtime/*,*/build/*,*/logs/*

" TagList
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:Tlist_Inc_Winwidth=0
let g:Tlist_Use_Right_Window=1
"let g:Tlist_Auto_Open=1
let g:Tlist_Show_One_File=1
"let g:Tlist_Compact_Format=1
"let g:Tlist_Enable_Fold_Column=0

" CtrlSF
:com! -n=* F CtrlSF <args>
:com! -n=0 FOpen CtrlSFOpen
"let g:ctrlsf_auto_close = 0

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

" neocomplete.vim
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets/'

" rainbow_parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadSquare " []
au Syntax * RainbowParenthesesLoadBraces " {}
"au Syntax * RainbowParenthesesLoadChevrons " <>

