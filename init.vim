" plug.vim {{ "
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lifepillar/vim-solarized8'
Plug 'trevordmiller/nova-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-markdown'
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
Plug 'Shougo/denite.nvim'
Plug 'janko-m/vim-test'
Plug 'airblade/vim-rooter'
Plug 'neoclide/coc.nvim', {'do': 'yarn install'}
Plug 'raghur/fruzzy', { 'do': { -> fruzzy#install()} }

Plug 'nacitar/a.vim', { 'on': 'A' }
Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }
Plug 'vim-scripts/TaskList.vim', { 'on': 'TaskList' }
Plug 'sbdchd/neoformat', {'on': 'Neoformat'}
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }
Plug 'sk1418/Join', { 'on': 'Join'}

Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'chemzqm/jsonc.vim', { 'for': 'jsonc' }

Plug 'sheerun/vim-polyglot'
call plug#end()
" }} plug.vim "

" functions {{ "
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! RenameCWord(cword)
  let l:cursor_pos = getpos(".")
  let l:word = expand("<".a:cword.">")
  let l:rename = input('Rename: ', l:word)
  if l:rename != ''
    execute "%s/\\<".l:word."\\>/".l:rename."/g"
  endif
  call cursor(l:cursor_pos[1], l:cursor_pos[2])
endfunction

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }} functions "

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

" basic {{ "
set fileencoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1

set termguicolors
let g:solarized_termcolors=256
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
  autocmd FileType ruby,html,javascript,typescript,css,json,vue setlocal shiftwidth=2 tabstop=2
  autocmd FileType crontab setlocal nobackup nowritebackup
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <C-g> :GoDecls<CR>
  autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')

  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufReadPost *.log normal! G
  autocmd BufNewFile,BufReadPost *.json setf jsonc

  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocQuickfixChange :<C-u>Denite -mode=normal quickfix

  " set up default omnifunc
  autocmd FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup end
" }} autocmd "

" command {{ "
command! W :w
command! Q :q
command! Qa :qa
command! Wa :wa
command! Wqa :wqa
command! WQa :wqa

command! Format :call CocAction('format')
command! Rename :call RenameCWord('cword')
command! PrettyJSON :%!python -m json.tool
command! CocExtensionInstall :CocInstall coc-json coc-tsserver coc-tslint coc-eslint coc-html coc-prettier coc-highlight coc-dictionary coc-tag coc-ultisnips
" }} command "

" ALE {{ "
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
let g:ale_virtualtext_cursor = 1
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> R :ALEFindReferences<CR>

let g:ale_linters = {
      \ 'python': ['pyls'],
      \ 'javascript': [],
      \ 'typescript': []
      \}
let g:ale_fixers = {
      \ '*' : ['trim_whitespace'],
      \ 'python' : ['yapf'],
      \}
" }} ALE "

" CtrlSF {{ "
:com! -n=* F CtrlSF <args>
let g:ctrlsf_auto_close = 0
" }} CtrlSF "

" TaskList {{ "
let g:tlTokenList = ['TODO', 'WTF', 'FIX']
" }} TaskList "

" UltiSnips {{ "
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" }} UltiSnips "

" vim-go {{ "
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
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
" }} vim-gutentags "

" echodoc {{ "
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = "virtual"
" }} echodoc "

" coc.nvim {{ "
let g:coc_auto_copen = 0

imap <silent> <C-x><C-u> <Plug>(coc-complete-custom)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> ge <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <space>a  :<C-u>Denite coc-diagnostic<CR>
nnoremap <silent> <space>o  :<C-u>Denite coc-symbols<CR>
nnoremap <silent> <space>w  :<C-u>Denite coc-workspace<CR>
nnoremap <silent> <space>c  :<C-u>Denite coc-command<CR>
" }} coc.nvim "

" Denite {{ "
call denite#custom#option('default', 'reversed', 1)
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#map(
      \ 'insert',
      \ '<C-a>',
      \ '<denite:move_caret_to_head>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-t>',
      \ '<denite:do_action:tabopen>',
      \ 'noremap'
      \)

nnoremap <silent> <space>b  :<C-u>Denite buffer<CR>
nnoremap <silent> <space>t  :<C-u>Denite tag<CR>
nnoremap <silent> <space>s  :<C-u>DeniteCursorWord  line<CR>
nnoremap <silent> <space>S  :<C-u>DeniteCursorWord  grep<CR>
nnoremap <silent> <space>q  :<C-u>Denite -mode=normal quickfix<CR>
nnoremap <silent> <space>j  :Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <silent> <space>k  :Denite -resume -cursor-pos=-1 -immediately<CR>
" }} Denite "

" vim-signify {{ "
let g:signify_vcs_list = [ 'git' ]

nmap <silent> gj <plug>(signify-next-hunk)
nmap <silent> gk <plug>(signify-prev-hunk)
" }} vim-signify "

" vim-test {{ "
let test#strategy = "neovim"
" }} vim-test "

" vim-markdown {{ "
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'typescript', 'ts=typescript']
" }} vim-markdown "

" Fruzzy {{ "
let g:fruzzy#usenative = 1
call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
" }} Fruzzy "

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
