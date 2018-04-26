set nocompatible              " be iMproved, required

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'tacahiroy/ctrlp-funky'
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'liuchengxu/eleline.vim'
Plug 'blueyed/argtextobj.vim' "via/cia
Plug 'michaeljsmith/vim-indent-object' "vii - o
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'nacitar/a.vim', { 'on': 'A' }
Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
Plug 'vim-scripts/TaskList.vim', { 'on': 'TaskList' }
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'sbdchd/neoformat', {'on': 'Neoformat'}
Plug 'vim-scripts/loremipsum', { 'on': 'Loremipsum' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'sk1418/Join', { 'on': 'Join'}

Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go'}
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader>ee :e $HOME/.config/nvim/init.vim<cr>
map <silent> <leader>dd :e $HOME/.config/nvim/dev.dict<cr>
setl dictionary+=$HOME/.config/nvim/dev.dict
map <silent> <leader>n :nohlsearch<cr>
inoremap <C-g> <Esc>
inoremap <C-c> <ESC>
inoremap jj <Esc>

nmap ? /\<\><Left><Left>
nmap t<Enter> :bo sp term://zsh\|resize 10<CR>i
tnoremap <Esc> <C-\><C-n>

set termguicolors
set guifont=Monaco:h15
set guifontwide=Monaco:h15
set background=dark
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
colorscheme solarized8

" Chinese encodingcoding
set encoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1
set fileencoding=utf-8

set hidden
set clipboard=unnamed
set number
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
set completeopt+=noselect
let do_syntax_sel_menu=1
set updatetime=100
set inccommand=split
setlocal noswapfile
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" some autocmd
autocmd FileType ruby,html,javascript,css,json setlocal shiftwidth=2 tabstop=2
autocmd filetype crontab setlocal nobackup nowritebackup

:command W w
:command Q q
:command Qa qa
:command Wa wa
:command Wqa wqa
:command WQa wqa

"" Recommended key-mappings. For no inserting <CR> key.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>\<C-y>" : "\<Tab>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return pumvisible() ? "\<C-n>\<C-y>" : "\<CR>"
endfunction

set wildignore+=*.pyc,*.sqlite,*.sqlite3,cscope.out
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/nginx_runtime/*,*/build/*,*/logs/*
set wildignore+=*/haddit_server1/*,*/haddit_server2/*,*/haddit_server3/*,*/haddit_server4/*,*/haddit_server5/*,*/haddit_server6/*,*/haddit_server7/*,*/haddit_server8/*,*/pgdata/*

let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python2'

" Plugin config.
" ALE
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_linters = {
            \ 'go': ['golint', 'go vet', 'go build'],
            \ 'python': ['pyls'],
            \}
let g:ale_fixers = {
            \ 'python' : ['autopep8', 'remove_trailing_lines', 'trim_whitespace'],
            \ 'javascript': ['prettier', 'remove_trailing_lines', 'trim_whitespace']
            \}

" CtrlP
let g:ctrlp_custom_ignore = '\v[\/](bower_components|node_modules|vendor|target|dist|_site|nginx_runtime|build|logs|data)|(\.(swp|ico|git|svn))$'
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

nnoremap <C-g> :CtrlPFunky<cr>
let g:ctrlp_funky_syntax_highlight = 1

" CtrlSF
:com! -n=* F CtrlSF <args>
let g:ctrlsf_auto_close = 0

" Tasklist
let g:tlTokenList = ['TODO', 'WTF', 'FIX']

" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" Vim-go
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_updatetime = 100

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <C-g> :GoDecls<cr>
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)

" langserver
autocmd FileType python LanguageClientStart
autocmd FileType lua LanguageClientStart
let g:LanguageClient_autoStart = 0
let g:LanguageClient_serverCommands = {
            \ 'lua': ['lua-lsp'],
            \ 'python': ['pyls'],
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ 'javascript': ['javascript-typescript-stdio'],
            \ 'javascript.jsx': ['javascript-typescript-stdio'],
            \ }

nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <c-]> :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> D :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> R :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> W :call LanguageClient_workspace_symbol()<CR>

" deoplete
let g:deoplete#enable_at_startup = 1

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#package_dot = 1
let g:deoplete#sources#go#pointer = 1

" FZF
let $FZF_DEFAULT_OPTS .= ' --inline-info'
if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

nnoremap <silent> <C-P> :Files<CR>
nnoremap <C-g> :BTags<cr>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
