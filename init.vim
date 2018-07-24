" plug.vim {{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'blueyed/argtextobj.vim' "via/cia
Plug 'michaeljsmith/vim-indent-object' "vii - o
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'ludovicchabant/vim-gutentags'
Plug 'farmergreg/vim-lastplace'
Plug 'Shougo/echodoc'
" Plug 'Shougo/neoinclude.vim'
" Plug 'Shougo/context_filetype.vim'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'do': 'yarn install'}

Plug 'nacitar/a.vim', { 'on': 'A' }
Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
Plug 'vim-scripts/TaskList.vim', { 'on': 'TaskList' }
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'sbdchd/neoformat', {'on': 'Neoformat'}
Plug 'vim-scripts/loremipsum', { 'on': 'Loremipsum' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'sk1418/Join', { 'on': 'Join'}

Plug 'fatih/vim-go', { 'for': 'go' }
" Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go'}
" Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }

call plug#end()
" }}

" mappings {{
map <silent> <leader>ee :e $HOME/.config/nvim/init.vim<cr>
map <silent> <leader>dd :e $HOME/.config/nvim/dev.dict<cr>
setl dictionary+=$HOME/.config/nvim/dev.dict

map ? /\<\><Left><Left>
map <silent> <leader>n :nohlsearch<cr>

nnoremap <Space> za

inoremap <C-c> <ESC>
inoremap jj <Esc>

nmap t<Enter> :bo sp term://zsh\|resize 10<CR>i
tnoremap <Esc> <C-\><C-n>

" Recommended key-mappings. For no inserting <CR> key.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>\<C-y>" : "\<Tab>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-n>\<C-y>" : "\<CR>"
endfunction

inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" }}

" basic {{
set fileencoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1

set termguicolors
set background=dark
let g:solarized_termcolors=256
colorscheme solarized8

set hidden
set clipboard=unnamed
set number
set expandtab
set tabstop=4
set shiftwidth=4
set nofoldenable
set foldmethod=indent
set showmatch
set matchtime=2
set matchpairs+=<:>
set ignorecase
set smartcase
set switchbuf=useopen,usetab,newtab
set updatetime=100
set inccommand=split
set noshowmode
set completeopt=menu
setlocal noswapfile
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" }}

" autocmd {{
augroup common
  autocmd!
  autocmd FileType ruby,html,javascript,typescript,css,json setlocal shiftwidth=2 tabstop=2
  autocmd Filetype crontab setlocal nobackup nowritebackup
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <C-g> :GoDecls<cr>
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')

  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufReadPost *.log normal! G
  autocmd CursorHoldI,CursorMovedI * call CocAction('showSignatureHelp')
  autocmd User CocQuickfixChange :lopen
  " autocmd BufNewFile,BufReadPost *.json setf jsonc

  " set up default omnifunc
  autocmd Filetype *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup end
" }}

" command {{
command! W w
command! Q q
command! Qa qa
command! Wa wa
command! Wqa wqa
command! WQa wqa
" }}

" wildignore {{
set wildignore+=*~,*/.git/*,*/.svn/*,*/.DS_Store
set wildignore+=*.pyc,*.sqlite,*.sqlite3,cscope.out
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.exe,*.min.js,*.min.css
set wildignore+=*/bower_components/*,bower_components/*,*/node_modules/*,node_modules/*,*/vendor/*,vendor/*
set wildignore+=*/nginx_runtime/*,nginx_runtime/*,*/build/*,build/*,*/logs/*,logs/*,*/dist/*,dist/*
" }}

" speedup {{
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:node_host_prog = '/Users/fannheyward/.config/yarn/global/node_modules/neovim/bin/cli.js'
" }}

" ALE {{
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> R :ALEFindReferences<CR>
nnoremap <silent> K :ALEHover<CR>

let g:ale_linters = {
      \ 'go': ['golint', 'go vet', 'go build'],
      \ 'python': ['pyls'],
      \}
let g:ale_fixers = {
      \ 'python' : ['yapf', 'remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
      \ 'typescript': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
      \}
" }}

" CtrlP {{
let g:ctrlp_custom_ignore = '\v[\/](bower_components|node_modules|vendor|target|dist|_site|nginx_runtime|build|logs|data)|(\.(swp|ico|git|svn))$'
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

nnoremap <C-g> :CtrlPFunky<cr>
let g:ctrlp_funky_syntax_highlight = 1
" }}

" CtrlSF {{
:com! -n=* F CtrlSF <args>
let g:ctrlsf_auto_close = 0
" }}

" Tasklist {{
let g:tlTokenList = ['TODO', 'WTF', 'FIX']
" }}

" Tagbar {{
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
" }}

" UltiSnips {{
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" }}

" Vim-go {{
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
" }}

" EasyAlign {{
vmap <Enter> <Plug>(EasyAlign)
" }}

" deoplete {{
let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#pointer = 1
" }}

" FZF {{
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
" }}

" vim-gutentags {{
set tags=./.tags;,.tags
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
" }}

" echodoc {{
let g:echodoc_enable_at_startup = 1
" }}

" coc.nvim {{
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call CocAction('doHover')<CR>
" }}

" lightline {{
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
" }}

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
