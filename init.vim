" plug.vim {{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'zef/vim-cycle'
Plug 'romainl/vim-cool'
Plug 'github/copilot.vim'
Plug 'honza/vim-snippets'
Plug 'liuchengxu/vim-clap'
Plug 'andymass/vim-matchup'
Plug 'echasnovski/mini.nvim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'ethanholz/nvim-lastplace'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'nvim-lualine/lualine.nvim'
Plug 'oncomouse/nvim-colorizer.lua'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'editorconfig/editorconfig-vim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'bronson/vim-visual-star-search'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sk1418/Join', { 'on': 'Join'}
Plug 'ggVGc/vim-fuzzysearch', { 'on': 'FuzzySearch' }
Plug 'AndrewRadev/inline_edit.vim', { 'on': 'InlineEdit' }

Plug 'fannheyward/go.vim', { 'for': 'go' }
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
set laststatus=3
set shiftwidth=4
set nofoldenable
set showmatch
set matchtime=2
set cursorline
set matchpairs+=<:>
set ignorecase
set smartcase
set switchbuf=useopen,usetab
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
set signcolumn=yes:1
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

let g:do_filetype_lua = 1
let g:did_load_filetypes = 1
" }} basic

" autocmd {{
augroup common
  autocmd!
  autocmd BufNewFile,BufRead *.jl setlocal filetype=julia
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  autocmd BufNewFile,BufRead *.jsx setlocal filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.json setlocal filetype=jsonc

  autocmd FileType go setlocal expandtab
  autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd FileType lua setlocal includeexpr=substitute(v:fname,'\\.','/','g')
  autocmd FileType lua setlocal include=require
  autocmd FileType lua setlocal define=function
  autocmd FileType markdown setlocal suffixesadd=.md
  autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
  autocmd FileType crontab setlocal nobackup nowritebackup
  autocmd FileType lua,ruby,html,javascript,typescript,css,json,vue,vim,yaml setlocal shiftwidth=2 tabstop=2
  autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
  autocmd FileType list lua require('bqf.magicwin.handler').attach()

  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  autocmd BufReadPost *.log normal! G
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow

  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocLocationsChange ++nested call s:coc_qf_jump2loc(g:coc_jump_locations)

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
command! -nargs=0 FixWhitespace lua MiniTrailspace.trim()

command! -nargs=+ Find          cgetexpr <SID>grep_to_qf(<f-args>)
command! -nargs=0 JSONPretty    %!python -m json.tool
command! -nargs=0 Todos         CocList -A --normal grep -e TODO|FIXME
command! -nargs=0 Status        CocList -A --normal gstatus
command! -nargs=0 Format        call CocAction('format')
command! -nargs=0 Fold          call CocAction('fold')
command! -nargs=0 GitChunkUndo  call CocAction('runCommand', 'git.chunkUndo')
command! -nargs=0 OR            call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Tsc           call CocAction('runCommand', 'tsserver.watchBuild')
command! -nargs=0 Jest          call CocActionAsync('runCommand', 'jest.fileTest', ['%'])
command! -nargs=0 VSCode        execute ":!code -g %:p\:" . line('.') . ":" . col('.')
command! -nargs=+ CocGrep       execute 'CocList -A --normal grep --smart-case '.<q-args>
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
nnoremap <silent><nowait> <space>s  :cgetexpr <SID>grep_to_qf(expand('<cword>'))<CR>

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
nmap g<Enter> :Telescope<CR>
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
    call CocActionAsync('definitionHover')
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

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
endif

function! s:grep_to_qf(...) abort
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

" nvim-bqf
function! s:coc_qf_diagnostic() abort
  if !get(g:, 'coc_service_initialized', 0)
    return
  endif
  let diagnostic_list = CocAction('diagnosticList')
  let items = []
  let loc_ranges = []
  for d in diagnostic_list
    let text = printf('[%s%s] %s', (empty(d.source) ? 'coc.nvim' : d.source),
          \ (d.code ? ' ' . d.code : ''), split(d.message, '\n')[0])
    let item = {'filename': d.file, 'lnum': d.lnum, 'col': d.col, 'text': text, 'type':
          \ d.severity[0]}
    call add(loc_ranges, d.location.range)
    call add(items, item)
  endfor
  call setqflist([], ' ', {'title': 'CocDiagnosticList', 'items': items,
        \ 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
  botright copen
endfunction

function! s:coc_qf_jump2loc(locs) abort
  let loc_ranges = map(deepcopy(a:locs), 'v:val.range')
  call setloclist(0, [], ' ', {'title': 'CocLocationList', 'items': a:locs,
        \ 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
  let winid = getloclist(0, {'winid': 0}).winid
  if winid == 0
    rightbelow lwindow
  else
    call win_gotoid(winid)
  endif
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
let g:go_fmt_command = "gofumpt"
" }} go.vim

" coc.nvim {{
let g:coc_enable_locationlist = 0
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
      \'coc-mocword',
      \'coc-pairs',
      \'coc-sh',
      \'coc-snippets',
      \'coc-sumneko-lua',
      \'coc-tag',
      \'coc-tsserver',
      \'coc-vimlsp',
      \'coc-webview',
      \'coc-xml',
      \'coc-yaml',
      \'coc-yank'
      \]

let g:coc_filetype_map = {
      \ 'asciidoc': 'markdown',
      \ }

" let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']
set runtimepath^=~/src/telescope-coc.nvim
set runtimepath^=~/src/telescope-maple.nvim
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
vnoremap <silent> K <cmd>call CocActionAsync('doHover')<CR>
nnoremap <silent><nowait> <space>a  :call <SID>coc_qf_diagnostic()<CR>
nnoremap <silent><nowait> <space>o  :<C-u>CocList -A outline -kind<CR>
nnoremap <silent><nowait> <space>l  :<C-u>CocList lines<CR>
nnoremap <silent><nowait> <space>q  :<C-u>CocList quickfix<CR>
nnoremap <silent><nowait> <space>m  :<C-u>CocList -A -N mru<CR>
nnoremap <silent><nowait> <space>w  :<C-u>CocList -I -N symbols<CR>
nnoremap <silent><nowait> <space>y  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent><nowait> <space>b  :<C-u>CocList -A -N --normal buffers<CR>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>S  :exe 'CocList -A --normal grep '.expand('<cword>').''<CR>
nnoremap <silent><nowait> <space>d  :call CocActionAsync('jumpDefinition', v:false)<CR>

imap <C-k> <Plug>(coc-snippets-expand)
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" }} coc.nvim

" nvim-hlslens {{
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>
" }}

" telescope.nvim {{
nnoremap <silent><nowait> <space>f  :<C-u>Telescope find_files<CR>
nnoremap <silent><nowait> <space>g  :<C-u>Telescope maple<CR>
" }}

" Lua {{
lua <<EOF
require('lualine').setup({
  options = {
    globalstatus = true
  },
  sections = {
    lualine_c = { 'filename', 'g:coc_status' }
  }
})

require('nvim-treesitter.configs').setup({
  ensure_installed = {"typescript"}, -- one of "all", "maintained", or a list of languages
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
})

require("telescope").setup({
  defaults = {
    generic_sorter = require('mini.fuzzy').get_telescope_sorter,
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
      }
    }
  }
})
require('telescope').load_extension('coc')
require('telescope').load_extension('maple')

require('mini.fuzzy').setup()
require('mini.comment').setup()
require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()
require('mini.indentscope').setup({
  draw = {
    animation = require('mini.indentscope').gen_animation('none')
  }
})
vim.cmd[[hi link MiniIndentscopeSymbol Comment]]

require('nvim-lastplace').setup()
EOF
" }}

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{,}} foldmethod=marker foldlevel=0:
