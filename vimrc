set nocompatible              " be iMproved, required

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'Valloric/YouCompleteMe'
Plug 'Valloric/ListToggle'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/TaskList.vim', { 'on': 'TaskList' }
Plug 'majutsushi/tagbar', { 'on': 'TagBar' }
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'nacitar/a.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-scripts/loremipsum'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-startify'
Plug 'fatih/vim-go'
Plug 'bling/vim-airline'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'dyng/ctrlsf.vim'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'scrooloose/syntastic'
Plug 'elzr/vim-json'
Plug 'marijnh/tern_for_vim'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>ee :e ~/.vimrc<cr>
map <silent> <leader>n :nohlsearch<cr>
inoremap <C-g> <Esc>
inoremap jj <Esc>
inoremap jk <ESC>

nmap ? /\<\><Left><Left>

set guifont=Monaco:h15
set guifontwide=Monaco:h15
set background=dark
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
colorscheme solarized

" Chinese encodingcoding
set encoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1
set fileencoding=utf-8

set number
setlocal noswapfile
set smartindent       "set smart indent
set expandtab
set tabstop=4
set shiftwidth=4
set nofoldenable
set foldmethod=indent
set showmatch
set matchtime=2
set matchpairs+=<:>
set hlsearch
set ignorecase smartcase
set completeopt=longest,menu
let do_syntax_sel_menu=1
set updatetime=200

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" some autocmd
autocmd FileType ruby,html,javascript,css,json setlocal shiftwidth=2 tabstop=2

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

cs add cscope.out

source $VIMRUNTIME/macros/matchit.vim

" Plugin config.
" CtrlP
let g:ctrlp_custom_ignore = '\v[\/](bower_components|node_modules|vendor|target|dist|_site|nginx_runtime|build|logs|data)|(\.(swp|ico|git|svn))$'

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

set wildignore+=*.pyc,*.sqlite,*.sqlite3,cscope.out
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/nginx_runtime/*,*/build/*,*/logs/*

" ctrlp_extensions
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1
:com! -n=0 D CtrlPFunky
nnoremap <Leader>fu :CtrlPFunky<Cr>
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

" CtrlSF
:com! -n=* F CtrlSF <args>
:com! -n=0 FOpen CtrlSFOpen
"let g:ctrlsf_auto_close = 0

" Tasklist
let g:tlTokenList = ['TODO' , 'WTF', 'FIX']

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
let g:tagbar_autoclose = 1

" NERDTree
let NERDTreeIgnore=['\.pyc', '\.out$', 'bak$', 'node_modules', 'dist']

" YCM
nnoremap <buffer> <silent> gd :YcmCompleter GoTo<cr>
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_server_log_level = 'error'

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" Vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
au FileType go nmap <leader>b <Plug>(go-build)

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ["jshint"]
let g:syntastic_shell = "/bin/sh"

