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
Plug 'jiangmiao/auto-pairs'
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

Plug 'fatih/vim-go', { 'for': 'go' }
" Plug 'Carpetsmoker/gopher.vim', { 'for': 'go' }
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
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <C-g> :GoDecls<CR>
  autocmd FileType go setlocal expandtab
  autocmd FileType go setlocal omnifunc=syntaxcomplete#Complete
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
" }} command "

" mappings {{ "
map <silent> <leader>ee :e $HOME/.config/nvim/init.vim<CR>
map <silent> <leader>dd :e $HOME/.config/nvim/dev.dict<CR>
setl dictionary+=$HOME/.config/nvim/dev.dict

map ? /\<\><Left><Left>
map <silent> <leader>n :nohlsearch<CR>

nnoremap <leader>cp :set clipboard=unnamed<CR>
nnoremap <leader>f :echom @%<CR>

inoremap <C-c> <ESC>
inoremap jj <Esc>

nnoremap <silent> gb :bn<CR>
nnoremap <silent> gB :bp<CR>

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

" vim-go {{ "
let g:go_fmt_autosave = 0
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_updatetime = 100
let g:go_doc_keywordprg_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'guru'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" }} vim-go "

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
let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-tsserver', 'coc-tslint-plugin', 'coc-eslint', 'coc-prettier', 'coc-highlight', 'coc-dictionary', 'coc-tag', 'coc-snippets', 'coc-lists', 'coc-yank', 'coc-syntax']

nmap <silent> gd :call <SID>GoToDefinition()<CR>
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-rename)
nmap <silent> ge <Plug>(coc-diagnostic-next)
nmap <silent> gq <Plug>(coc-fix-current)

vmap <leader> f  <Plug>(coc-format-selected)

inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
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
nnoremap <silent> <space>S  :exe 'CocList --normal grep '.expand('<cword>').''<CR>

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
