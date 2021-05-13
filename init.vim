" plug.vim {{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'zef/vim-cycle'
Plug 'romainl/vim-cool'
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'tpope/vim-commentary'
Plug 'andymass/vim-matchup'
Plug 'nvim-lua/plenary.nvim'
Plug 'liuchengxu/eleline.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'glepnir/indent-guides.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nacitar/a.vim', { 'on': 'A' }
Plug 'sk1418/Join', { 'on': 'Join'}
Plug 'liuchengxu/vista.vim', { 'on': 'Vista' }
Plug 'AndrewRadev/inline_edit.vim', { 'on': 'InlineEdit' }
Plug 'bronson/vim-trailing-whitespace', { 'on': 'FixWhitespace' }

Plug 'fannheyward/go.vim', { 'for': 'go' }
" Plug 'rust-lang/rust.vim', { 'for': 'rust' }

Plug 'neoclide/jsonc.vim'
call plug#end()
" }} plug.vim

" basic {{
set fileencoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1

set termguicolors
colorscheme dracula

set title
set hidden
set number
set expandtab
set tabstop=4
set shiftwidth=4
set nofoldenable
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
set jumpoptions=stack
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set formatexpr=CocActionAsync('formatSelected')
set tagfunc=CocTagFunc
set shortmess+=c
set diffopt+=internal,algorithm:patience
set pumheight=20
set list listchars=tab:\|\ ,trail:·,eol:¬
setlocal noswapfile
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0
" }} basic

" autocmd {{
augroup common
  autocmd!
  autocmd BufNewFile,BufReadPost *.md setfiletype markdown
  autocmd BufNewFile,BufReadPost *.tsx setfiletype typescript.tsx
  autocmd BufNewFile,BufReadPost *.jsx setfiletype javascript.jsx
  autocmd BufNewFile,BufReadPost *.jl setfiletype julia

  autocmd FileType go setlocal expandtab
  autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd FileType lua setlocal includeexpr=substitute(v:fname,'\\.','/','g')
  autocmd FileType lua setlocal include=require
  autocmd FileType lua setlocal define=function
  autocmd FileType markdown setlocal suffixesadd=.md
  autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
  autocmd FileType crontab setlocal nobackup nowritebackup
  autocmd FileType lua,ruby,html,javascript,typescript,css,json,vue,vim,yaml setlocal shiftwidth=2 tabstop=2

  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufReadPost *.log normal! G

  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocQuickfixChange :CocList --normal quickfix

  autocmd BufWritePre *.go silent! :call CocAction('runCommand', 'editor.action.organizeImport')

  " set up default omnifunc
  autocmd FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup end
" }} autocmd

" command {{
command! -nargs=0 E     e
command! -nargs=0 Q     q
command! -nargs=0 Qa    qa
command! -nargs=0 T     tabnew
command! -nargs=0 W     w
command! -nargs=0 Wa    wa
command! -nargs=0 Wqa   wqa
command! -nargs=0 WQa   wqa

command! -nargs=0 C             CocConfig
command! -nargs=0 L             CocListResume
command! -nargs=0 -range D      CocCommand
command! -nargs=0 Prettier      CocCommand prettier.formatFile
command! -nargs=0 CocOutput     CocCommand workspace.showOutput

command! -nargs=0 JSONPretty    %!python -m json.tool
command! -nargs=0 Todos         CocList -A --normal grep -e TODO|FIXME
command! -nargs=0 Status        CocList -A --normal gstatus
command! -nargs=+ Find          exe 'CocList -A --normal grep --smart-case '.<q-args>
command! -nargs=0 Format        call CocAction('format')
command! -nargs=0 Fold          call CocAction('fold')
command! -nargs=0 GitChunkUndo  call CocAction('runCommand', 'git.chunkUndo')
command! -nargs=0 OR            call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Tsc           call CocAction('runCommand', 'tsserver.watchBuild')
command! -nargs=0 Jest          call CocActionAsync('runCommand', 'jest.fileTest', ['%'])
command! -nargs=0 JunkFile      call s:open_junk_file()
command! -nargs=0 JunkList      call s:open_junk_list()
command! -nargs=0 VSCode        execute ":!code -g %:p\:" . line('.') . ":" . col('.')
" }} command

" mappings {{
map <silent> <leader>ee :e $HOME/.config/nvim/init.vim<CR>
map <silent> <leader>dd :e $HOME/.config/nvim/dev.dict<CR>
setl dictionary+=$HOME/.config/nvim/dev.dict

map ? /\<\><Left><Left>
map <silent> <leader>n :nohlsearch<CR>

vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap <leader>cp :set clipboard=unnamed<CR>

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
inoremap <C-n> <Down>
inoremap <C-p> <Up>
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
" }} mappings

" functions {{
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

function! s:GoToDefinition()
  if CocActionAsync('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret =~ "Error" || ret =~ "错误"
    call searchdecl(expand('<cword>'))
  endif
endfunction

function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

function! CopyFloatText() abort
  let id = win_getid()
  let winid = coc#float#get_float_win()
  if winid
    call win_gotoid(winid)
    execute 'normal! ggvGy'
    call win_gotoid(id)
  endif
endfunction

" Open junk file.
function! s:open_junk_file()
  let junk_dir = get(g:, 'asc_junk', '~/.vim/junk')
  let junk_dir = expand(junk_dir)
  if !isdirectory(junk_dir)
    call mkdir(junk_dir, 'p')
  endif

  let filename = junk_dir.strftime('/%Y-%m-%d-%H%M%S.md')
  let filename = tr(filename, '\', '/')
  let filename = input('Junk Code: ', filename)
  if filename != ''
    execute 'edit ' . fnameescape(filename)
  endif
endfunction

function! s:open_junk_list()
  let junk_dir = get(g:, 'asc_junk', '~/.vim/junk')
  let junk_dir = expand(junk_dir)
  if !isdirectory(junk_dir)
    call mkdir(junk_dir, 'p')
  endif
  let junk_dir = tr(junk_dir, '\', '/')
  exec "CtrlP " . fnameescape(junk_dir)
endfunction
" }} functions

" wildignore {{
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.log,*.pyc,*.sqlite,*.sqlite3,*.min.js,*.min.css,*.tags
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.pdf,*.dmg,*.app,*.ipa,*.apk,*.mobi,*.epub
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.doc,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*/.git/*,*/.svn/*,*.DS_Store
set wildignore+=*/node_modules/*,*/nginx_runtime/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*
" }} wildignore

" CtrlP {{
nnoremap <silent> <C-l> :CtrlPLine<CR>

if executable('fd')
  let g:ctrlp_user_command = 'fd --type file'
  let g:ctrlp_use_caching = 0
endif
" }} CtrlP

" vim-gutentags {{
set tags=./.tags;,.tags
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
let g:gutentags_ctags_exclude = ['*.md', '*.json', '*.js', '*.ts', '*.jsx', '*.css', '*.less', '*.sass', '*.go', '*.dart', 'node_modules', 'dist', 'vendor']
" }} vim-gutentags

" vim-rooter {{
let g:rooter_patterns = ['.root', 'package.json', '.git/']
" }} vim-rooter

" go.vim {{
let g:go_fmt_command = "gofumports"
" }} go.vim

" Netrw {{
if has('macunix')
  function! OpenURLUnderCursor()
    let s:uri = expand('<cWORD>')
    let s:uri = matchstr(s:uri, '[a-z]*:\/\/[^ >,;()]*')
    let s:uri = substitute(s:uri, '?', '\\?', '')
    let s:uri = shellescape(s:uri, 1)
    if s:uri != ''
      silent exec "!open '".s:uri."'"
      :redraw!
    endif
  endfunction
  nnoremap gx :call OpenURLUnderCursor()<CR>
endif
let g:netrw_chgwin = 2
let g:netrw_list_hide = ',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_winsize=20
let g:netrw_liststyle=3
" }} Netrw

" coc.nvim {{
let g:coc_global_extensions = [
      \'coc-dictionary',
      \'coc-docthis',
      \'coc-ecdict',
      \'coc-eslint',
      \'coc-git',
      \'coc-go',
      \'coc-html',
      \'coc-json',
      \'coc-lists',
      \'coc-markdownlint',
      \'coc-marketplace',
      \'coc-nextword',
      \'coc-pairs',
      \'coc-sh',
      \'coc-snippets',
      \'coc-tag',
      \'coc-tsserver',
      \'coc-vimlsp',
      \'coc-xml',
      \'coc-yaml',
      \'coc-yank'
      \]

let g:coc_filetype_map = {
      \ 'asciidoc': 'markdown',
      \ }

" let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']
set runtimepath^=~/src/coc-rust-analyzer
set runtimepath^=~/src/coc-pyright
" set runtimepath^=~/src/coc-pylance
set runtimepath^=~/src/coc-clangd

nmap <silent> gd :call <SID>GoToDefinition()<CR>
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references-used)
nmap <silent> gn <Plug>(coc-rename)
nmap <silent> ge <Plug>(coc-diagnostic-next)
nmap <silent> gA <Plug>(coc-codeaction)
nmap <silent> gl <Plug>(coc-codeaction-line)
nmap <silent> ga <Plug>(coc-codeaction-cursor)
nmap <silent> gk <Plug>(coc-fix-current)
nmap <silent> gs <Plug>(coc-git-chunkinfo)
nmap <silent> gm <Plug>(coc-git-commit)
omap <silent> ig <Plug>(coc-git-chunk-inner)
xmap <silent> ig <Plug>(coc-git-chunk-inner)

nmap <silent> <expr> [c &diff ? '[c' : '<Plug>(coc-git-prevchunk)'
nmap <silent> <expr> ]c &diff ? ']c' : '<Plug>(coc-git-nextchunk)'
nmap <silent> <expr> <C-d> <SID>select_current_word()
nmap <silent> <C-c> <Plug>(coc-cursors-position)
xmap <silent> <C-d> <Plug>(coc-cursors-range)

nmap <leader>l  <Plug>(coc-codelens-action)
nmap <leader>x  <Plug>(coc-cursors-operator)
nmap <leader>rf <Plug>(coc-refactor)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent><nowait> <space>o  :<C-u>CocList -A outline -kind<CR>
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<CR>
nnoremap <silent><nowait> <space>l  :<C-u>CocList lines<CR>
nnoremap <silent><nowait> <space>q  :<C-u>CocList quickfix<CR>
nnoremap <silent><nowait> <space>w  :<C-u>CocList -I -N symbols<CR>
nnoremap <silent><nowait> <space>y  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent><nowait> <space>b  :<C-u>CocList -A -N --normal buffers<CR>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>d  :call CocActionAsync('jumpDefinition', v:false)<CR>

imap <C-k> <Plug>(coc-snippets-expand)
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

call coc#add_command('tree', 'Vexplore', 'open netrw explorer')
" }} coc.nvim

" telescope.nvim/nvim-treesitter {{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"typescript"}, -- one of "all", "maintained", or a list of languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  matchup = {
    enable = true,
  },
  indent = {
    enable = true
  }
}

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  }
}
require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')
EOF
nnoremap <silent><nowait> <space>g :Telescope live_grep<CR>
nnoremap <silent><nowait> <space>f :Telescope find_files<CR>
nnoremap <silent><nowait> <space>s :Telescope grep_string<CR>
nnoremap <silent><nowait> <space>m :Telescope coc mru<CR>
" }}

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
