set nocompatible              " be iMproved, required

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'Valloric/ListToggle'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/TaskList.vim', { 'on': 'TaskList' }
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nacitar/a.vim', { 'on': 'A' }
Plug 'altercation/vim-colors-solarized'
Plug 'bronson/vim-trailing-whitespace'
Plug 'vim-scripts/loremipsum'
Plug 'tpope/vim-commentary'
Plug 'fatih/vim-go'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
Plug 'elzr/vim-json'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sk1418/Join'
Plug 'easymotion/vim-easymotion'
Plug 'chase/vim-ansible-yaml'
Plug 'w0rp/ale'
Plug 'xolox/vim-misc'
Plug 'https://git.oschina.net/iamdsy/vim-lua-ftplugin'

if has('nvim')
    Plug 'Shougo/deoplete.nvim'
    Plug 'Shougo/context_filetype.vim'
    Plug 'zchee/deoplete-jedi'
    Plug 'mhartington/deoplete-typescript'
    Plug 'carlitux/deoplete-ternjs'
    Plug 'zchee/deoplete-go', { 'do': 'make'}
    tnoremap <Esc> <C-\><C-n>
endif

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>ee :e $HOME/.config/nvim/init.vim<cr>
map <silent> <leader>dd :e $HOME/.config/nvim/fannheyward.dict<cr>
setl dictionary+=$HOME/.config/nvim/fannheyward.dict
map <silent> <leader>n :nohlsearch<cr>
inoremap <C-g> <Esc>
inoremap jj <Esc>

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

set clipboard=unnamed
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
set completeopt+=noinsert
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
  " return pumvisible() ? "\<C-n>\<C-y>" : "\<CR>"
  return pumvisible() ? deoplete#close_popup() : "\<CR>"
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
set wildignore+=*/haddit_server1/*,*/haddit_server2/*,*/haddit_server3/*,*/haddit_server4/*,*/haddit_server5/*,*/haddit_server6/*,*/haddit_server7/*,*/haddit_server8/*,*/pgdata/*

" CtrlSF
:com! -n=* F CtrlSF <args>
let g:ctrlsf_auto_close = 0

" Tasklist
let g:tlTokenList = ['TODO' , 'WTF', 'FIX']

" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" NERDTree
let NERDTreeIgnore=['\.pyc', '\.out$', 'bak$', 'node_modules', 'dist', 'pgdata']

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" Vim-go
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_updatetime = 200

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
au FileType go nmap <leader>b <Plug>(go-build)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" deoplete
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python2'
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr> <Tab> pumvisible() ? deoplete#close_popup() : "\<tab>"
let g:deoplete#sources#tss#javascript_support = 1

" EasyMotion
let g:EasyMotion_keys = 'abcdefghijkmnqrstuvwxyz'

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go'
let g:deoplete#sources#go#package_dot = 1
let g:deoplete#sources#go#pointer = 1

" Lua
let g:lua_interpreter_path = '/usr/local/openresty/bin/resty'
let $LUA_PATH = '/usr/local/openresty/lualib/resty/?.lua'
let $LUA_CPATH = '/usr/local/openresty/lualib/?.so'
let g:lua_complete_omni = 1
