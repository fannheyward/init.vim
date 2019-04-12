" plug.vim {{ "
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'honza/vim-snippets'
Plug 'trevordmiller/nova-vim'
Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-apathy'
Plug 'liuchengxu/eleline.vim'
Plug 'blueyed/argtextobj.vim' "via/cia
Plug 'michaeljsmith/vim-indent-object' "vii - o
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'ludovicchabant/vim-gutentags'
Plug 'farmergreg/vim-lastplace'
Plug 'airblade/vim-rooter'
Plug 'zef/vim-cycle'
Plug 'nelstrom/vim-visual-star-search'
Plug 'neoclide/vim-jsx-improve'
Plug 'sgur/vim-editorconfig'
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }

Plug 'nacitar/a.vim', { 'on': 'A' }
Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
Plug 'jontrainor/TaskList.vim', { 'on': 'TaskList' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'sk1418/Join', { 'on': 'Join'}
Plug 'liuchengxu/vista.vim', { 'on': 'Vista' }

Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }

Plug 'sheerun/vim-polyglot'
Plug 'neoclide/jsonc.vim'
call plug#end()
" }} plug.vim "

" basic {{ "
set fileencoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1

set termguicolors
colorscheme nova

set hidden
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
set cmdheight=2
set formatexpr=CocAction('formatSelected')
set shortmess+=c
set diffopt+=internal,algorithm:patience
set wildoptions=pum
set pumheight=20
setlocal noswapfile
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
" }} basic "

" autocmd {{ "
augroup common
  autocmd!
  autocmd FileType go setlocal expandtab
  autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd FileType lua setlocal includeexpr=substitute(v:fname,'\\.','/','g')
  autocmd FileType lua setlocal include=require
  autocmd FileType lua setlocal define=function
  autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
  autocmd FileType crontab setlocal nobackup nowritebackup
  autocmd FileType ruby,html,javascript,typescript,css,json,vue setlocal shiftwidth=2 tabstop=2

  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufReadPost *.log normal! G
  autocmd BufNewFile,BufReadPost *.md setfiletype markdown
  autocmd BufNewFile,BufReadPost *.tsx setfiletype typescript.tsx
  autocmd BufNewFile,BufReadPost *.jsx setfiletype javascript.jsx

  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocQuickfixChange :CocList --normal quickfix

  " set up default omnifunc
  autocmd FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup end
" }} autocmd "

" command {{ "
command! -nargs=0 E     :e
command! -nargs=0 Q     :q
command! -nargs=0 Qa    :qa
command! -nargs=0 T     :tabnew
command! -nargs=0 W     :w
command! -nargs=0 Wa    :wa
command! -nargs=0 Wqa   :wqa
command! -nargs=0 WQa   :wqa

command! -nargs=0 C     :CocConfig
command! -nargs=0 S     :SignifyRefresh
command! -nargs=0 R     :CocListResume

command! -nargs=0 Format      :call CocAction('format')
command! -nargs=0 JSONPretty  :%!python -m json.tool
command! -nargs=0 Todos       :CocList -A --normal grep -e TODO|FIXME
" }} command "

" mappings {{ "
map <silent> <leader>ee :e $HOME/.config/nvim/init.vim<CR>
map <silent> <leader>dd :e $HOME/.config/nvim/dev.dict<CR>
setl dictionary+=$HOME/.config/nvim/dev.dict

map ? /\<\><Left><Left>
map <silent> <leader>n :nohlsearch<CR>

nnoremap <leader>cp :set clipboard=unnamed<CR>
nnoremap <leader>f :echomsg @%<CR>

nnoremap <silent> gb :bn<CR>
nnoremap <silent> gB :bp<CR>

" insert mode
inoremap <C-c> <ESC>
inoremap <C-w> <C-[>diwa
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-u> <C-G>u<C-U>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <expr><C-e> pumvisible() ? "\<C-e>" : "\<End>"

" command line mappings
cnoremap <C-a> <Home>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>

nmap t<Enter> :bo sp term://zsh\|resize 10<CR>i
tnoremap <Esc> <C-\><C-n>
" }} mappings "

" functions {{ "
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

function! s:GoToDefinition()
  function! s:handler(err, resp)
    let line = coc#util#echo_line()
    if line =~ 'Definition not found'
      call searchdecl(expand('<cword>'))
    endif
  endfunction

  call CocActionAsync('jumpDefinition', function('s:handler'))
endfunction
" }} functions "

" wildignore {{ "
set wildignore+=*/.git/*,*/.svn/*,*/.DS_Store
set wildignore+=*.log,*.pyc,*.sqlite,*.sqlite3,cscope.out
set wildignore+=*.so,*.swp,*.zip,*.exe,*.min.js,*.min.css
set wildignore+=*/node_modules/*,*/bower_components/*,/vendor/*
set wildignore+=*/nginx_runtime/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*
" }} wildignore "

" CtrlSF {{ "
:com! -n=* F CtrlSF <args>
let g:ctrlsf_auto_close = 0
" }} CtrlSF "

" FZF {{ "
let $FZF_DEFAULT_OPTS .= ' --inline-info'
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

nnoremap <silent> <C-P> :Files<CR>
nnoremap <C-g> :BTags<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" }} FZF "

" vim-gutentags {{ "
set tags=./.tags;,.tags
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project']
let g:gutentags_exclude_filetypes = ['json', 'jsonc', 'javascript', 'javascript.jsx', 'typescript', 'typescript.jsx', 'css', 'less', 'sass', 'go', 'gitcommit']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
" }} vim-gutentags "

" coc.nvim {{ "
let g:coc_global_extensions = ['coc-pairs', 'coc-json', 'coc-html', 'coc-tsserver', 'coc-tslint-plugin', 'coc-eslint', 'coc-prettier', 'coc-highlight', 'coc-dictionary', 'coc-tag', 'coc-snippets', 'coc-lists', 'coc-yank', 'coc-syntax']

nmap <silent> gd :call <SID>GoToDefinition()<CR>
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-rename)
nmap <silent> ge <Plug>(coc-diagnostic-next)
nmap <silent> gx <Plug>(coc-fix-current)
nmap <silent> ga <Plug>(coc-codeaction)

vmap <leader> f  <Plug>(coc-format-selected)
vmap <leader> a  <Plug>(coc-codeaction-selected)

inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
	      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <space>o  :<C-u>Vista finder coc<CR>
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<CR>
nnoremap <silent> <space>l  :<C-u>CocList locationlist<CR>
nnoremap <silent> <space>q  :<C-u>CocList quickfix<CR>
nnoremap <silent> <space>w  :<C-u>CocList -I -N symbols<CR>
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent> <space>m  :<C-u>CocList -A -N mru<CR>
nnoremap <silent> <space>t  :<C-u>CocList -A -N --normal buffers<CR>
nnoremap <silent> <space>s  :exe 'CocList -A -I --normal --input='.expand('<cword>').' words'<CR>
nnoremap <silent> <space>S  :exe 'CocList -A --normal grep '.expand('<cword>').''<CR>

imap <C-k> <Plug>(coc-snippets-expand)
" }} coc.nvim "

" vim-signify {{ "
let g:signify_vcs_list = [ 'git' ]

nmap <silent> gj <plug>(signify-next-hunk)
nmap <silent> gk <plug>(signify-prev-hunk)
" }} vim-signify "

" vim-rooter {{ "
let g:rooter_patterns = ['.root', 'package.json', '.git/']
" }} vim-rooter "

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
