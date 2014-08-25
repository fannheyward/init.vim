set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'Shougo/neosnippet'
"Plugin 'Shougo/neosnippet-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'nacitar/a.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'fannheyward/rainbow_parentheses.vim'
Plugin 'vim-scripts/loremipsum'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'dyng/ctrlsf.vim'
Plugin 'mhinz/vim-startify'
Plugin 'fatih/vim-go'
Plugin 'bling/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set timeout timeoutlen=1000 ttimeoutlen=10

map <silent> <leader>ee :e ~/.vimrc<cr>
map <silent> <leader>n :noh<cr>

nmap ? /\<\><Left><Left>

set guifont=Monaco:h15
set guifontwide=Monaco:h15
colorscheme slate
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
set nofoldenable
set foldmethod=indent
set showmatch
set matchtime=2
set matchpairs+=<:>
syntax on
set hlsearch
set ignorecase smartcase incsearch
set completeopt=longest,menu
set backspace=indent,eol,start
let do_syntax_sel_menu=1
set updatetime=200
set scrolloff=2

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" some autocmd
autocmd FileType json setlocal equalprg=python -mjson.tool
autocmd FileType html,javascript,css setlocal shiftwidth=2 tabstop=2

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

:command W w
:command Q q
:command Qa qa
:command Wa wa
:command Wqa wqa
:command WQa wqa

"" Recommended key-mappings. For no inserting <CR> key.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-n>\<C-y>" : "\<CR>"
endfunction

" Plugin config.
" CtrlP
let g:ctrlp_custom_ignore = '\v[\/](bower_components|node_modules|vendor|target|dist|_site|nginx_runtime|build|logs|data)|(\.(swp|ico|git|svn))$'

set wildignore+=*.pyc,*.sqlite,*.sqlite3
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/nginx_runtime/*,*/build/*,*/logs/*

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

" vim-go
let g:go_snippet_engine = "neosnippet"

" Startify
let g:startify_custom_header = [
    \'  YYYYYY       YYYYYYYY EEEEEEEEEEEEEEEEEEEEE    SSSSSSSSSSSSSSS',
    \'  Y:::::Y       Y:::::Y E::::::::::::::::::::E  SS:::::::::::::::S',
    \'  Y:::::Y       Y:::::Y E::::::::::::::::::::E S:::::SSSSSS::::::S',
    \'  Y::::::Y     Y::::::Y EE::::::EEEEEEEEE::::E S:::::S     SSSSSSS',
    \'  YYY:::::Y   Y:::::YYY   E:::::E       EEEEEE S:::::S',
    \'     Y:::::Y Y:::::Y      E:::::E              S:::::S',
    \'      Y:::::Y:::::Y       E::::::EEEEEEEEEE     S::::SSSS',
    \'       Y:::::::::Y        E:::::::::::::::E      SS::::::SSSSS',
    \'        Y:::::::Y         E:::::::::::::::E        SSS::::::::SS',
    \'         Y:::::Y          E::::::EEEEEEEEEE           SSSSSS::::S',
    \'         Y:::::Y          E:::::E                          S:::::S',
    \'         Y:::::Y          E:::::E       EEEEEE             S:::::S',
    \'         Y:::::Y        EE::::::EEEEEEEE:::::E SSSSSSS     S:::::S',
    \'      YYYY:::::YYYY     E::::::::::::::::::::E S::::::SSSSSS:::::S',
    \'      Y:::::::::::Y     E::::::::::::::::::::E S:::::::::::::::SS',
    \'      YYYYYYYYYYYYY     EEEEEEEEEEEEEEEEEEEEEE  SSSSSSSSSSSSSSS',
    \'',
    \]

" Tagbar
let g:tagbar_autofocus = 1

