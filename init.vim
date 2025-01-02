" plug.vim {{{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'https://github.com/zef/vim-cycle'
Plug 'https://github.com/tpope/vim-sleuth'
Plug 'https://github.com/github/copilot.vim'
Plug 'https://github.com/echasnovski/mini.nvim'
Plug 'https://github.com/kevinhwang91/nvim-bqf'
Plug 'https://github.com/azabiong/vim-highlighter'
Plug 'https://github.com/chrisgrieser/nvim-origami'
Plug 'https://github.com/kevinhwang91/nvim-hlslens'
Plug 'https://github.com/ludovicchabant/vim-gutentags'
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'master', 'do': 'npm i'}
" Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}

Plug 'https://github.com/catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'https://github.com/tweekmonster/helpful.vim', { 'on': 'HelpfulVersion' }
Plug 'https://github.com/AndrewRadev/inline_edit.vim', { 'on': 'InlineEdit' }
call plug#end()
" }}}} plug.vim

" basic {{{{
set fileencoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1

colorscheme catppuccin-frappe

set title
set hidden
set number
set mouse=i
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
set startofline
set diffopt+=linematch:50
set switchbuf=useopen,usetab
set updatetime=100
set inccommand=split
set noshowmode
set completeopt=menu
set cmdheight=2
set jumpoptions=stack
set foldmethod=expr
set formatexpr=CocAction('formatSelected')
set tagfunc=CocTagFunc
set signcolumn=yes:1
set shortmess+=c
set diffopt+=internal,algorithm:patience
set pumheight=20
set jumpoptions=stack
set list listchars=tab:\›\ ,trail:·,eol:¬,leadmultispace:---+,nbsp:⍽,extends:>,precedes:<
setlocal noswapfile
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

let loaded_matchit = 1
let loaded_spellfile_plugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_matchit = 1
let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0

cnoreabbr <expr> Wq getcmdline() == 'Wq' ? 'wq' : 'Wq'
" }}}} basic

" autocmd {{{{
augroup common
  autocmd!
  autocmd BufNewFile,BufRead *.jl setlocal filetype=julia
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  autocmd BufNewFile,BufRead *.jsx setlocal filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.json setlocal filetype=jsonc
  autocmd BufNewFile,BufRead deno.lock setlocal filetype=json
  autocmd BufNewFile,BufRead go.work.sum setlocal filetype=gosum
  autocmd BufNewFile,BufRead go.work setlocal filetype=gowork
  autocmd BufNewFile,BufRead LICENSE setlocal filetype=license

  autocmd FileType go setlocal expandtab
  autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd FileType lua setlocal includeexpr=substitute(v:fname,'\\.','/','g')
  autocmd FileType lua setlocal include=require
  autocmd FileType lua setlocal define=function
  autocmd FileType markdown setlocal suffixesadd=.md
  autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
  autocmd FileType crontab setlocal nobackup nowritebackup
  autocmd FileType lua,ruby,html,javascript,typescript,css,json,vue,vim,yaml setlocal shiftwidth=2 tabstop=2
  autocmd Filetype vue setlocal iskeyword+=-
  autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
  autocmd FileType list lua require('bqf.magicwin.handler').attach()

  autocmd BufReadPost *.log normal! G
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow

  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocLocationsChange call s:coc_qf_jump2loc(g:coc_jump_locations)

  " set up default omnifunc
  autocmd FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup end
" }}}} autocmd

" commands {{{{
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
command! -nargs=0 CocDebug      CocCommand workspace.showOutput
command! -nargs=0 Files         lua require('mini.files').open()
command! -nargs=0 FixWhitespace lua require('mini.trailspace').trim()

command! -nargs=+ Find          cgetexpr <SID>grep_to_qf(<f-args>)
command! -nargs=0 JSONPretty    %!python3 -m json.tool
command! -nargs=0 Todos         CocList -A --normal grep -w TODO|FIXME|FIX|FIXIT|BUG|HACK|XXX
command! -nargs=0 Format        call CocAction('format')
command! -nargs=0 Fold          call CocAction('fold')
command! -nargs=0 GitStatus     CocList -A --normal gstatus
command! -nargs=0 GitChunkUndo  call CocAction('runCommand', 'git.chunkUndo')
command! -nargs=0 VSCode        silent! execute ":!code -g %:p\:" . line('.') . ":" . col('.')
command! -nargs=0 Zed           silent! execute ":!zed --new %:" . line('.') . ":" . col('.')
command! -nargs=0 BOnly         silent! execute "%bd\|e#\|bd#"
" }}}} commands

" mappings {{{{
nmap <nowait> yc yygccp
nmap <silent> <leader>ee :e $HOME/.config/nvim/init.vim<CR>
nmap <silent> <leader>dd :e $HOME/.config/nvim/dev.dict<CR>
setl dictionary+=$HOME/.config/nvim/dev.dict

nmap ? /\<\><Left><Left>
nmap <silent> <leader>n :nohlsearch<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nnoremap <leader>cp :set clipboard=unnamed<CR>
nnoremap <leader>sr :%s/<<C-R><C-W>>//g<Left><Left>

nnoremap <silent> gb :bn<CR>
nnoremap <silent> gB :bp<CR>
nnoremap <silent><nowait> <C-c> ciw
nnoremap <silent><nowait> <tab><tab> :Pick buffers<CR>
nnoremap <silent><nowait> <space>b  :Pick buffers<CR>
nnoremap <silent><nowait> <space>f  :Pick files tool=rg<CR>
nnoremap <silent><nowait> <space>g  :Pick grep_live tool=rg<CR>
nnoremap <silent><nowait> <space>s  :cgetexpr <SID>grep_to_qf(expand('<cword>'))<CR>
nnoremap <silent><nowait> <space>S  :cgetexpr <SID>grep_to_qf(expand('<cword>'), expand('%'))<CR>
nnoremap <silent><nowait> <space>r  :if &modifiable \| setl noma \| echo 'non-modifiable' \| else \| setl ma \| echo 'modifiable' \| endif<CR>
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'

" insert mode
inoremap <C-c> <ESC>
inoremap <C-w> <C-[>diwa
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-u> <C-G>u<C-U>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<End>"

" command line mappings
cnoremap <C-a> <Home>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>
cnoremap <expr> <space> getcmdtype() =~ '[/?]' ? '.\{-}' : "<space>"

nmap t<Enter> :bo sp term://zsh\|resize 10<CR>i
tnoremap <Esc> <C-\><C-n>
" }}}} mappings

" functions {{{{
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! s:next_char_pair() abort
  let col = col('.') - 1
  echom getline('.')[col]
  return getline('.')[col] =~# ')\|]\|}\|>\|''\|"\|`'
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

function! s:go_to_definition()
  if CocActionAsync('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret =~ "Error" || ret =~ "错误"
    call searchdecl(expand('<cword>'))
  endif
endfunction

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --word-regexp
endif

function! s:grep_to_qf(...) abort
  return system(join([&grepprg] + [a:1] + [expandcmd(join(a:000[1:-1], ' '))], ' '))
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
    let text = printf('[%s%s] %s', (empty(d.source) ? 'coc.nvim' : d.source), (has_key(d, 'code') ? ' ' . d.code : ''), split(d.message, '\n')[0])
    let item = {'filename': d.file, 'lnum': d.lnum, 'end_lnum': d.end_lnum, 'col': d.col, 'end_col': d.end_col, 'text': text, 'type': d.severity[0]}
    call add(loc_ranges, d.location.range)
    call add(items, item)
  endfor
  call setqflist([], ' ', {'title': 'CocDiagnosticList', 'items': items, 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
  botright copen
endfunction

function! s:coc_qf_jump2loc(locs) abort
  let loc_ranges = map(deepcopy(a:locs), 'v:val.range')
  call setloclist(0, [], ' ', {'title': 'CocLocationList', 'items': a:locs, 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
  let winid = getloclist(0, {'winid': 0}).winid
  if winid == 0
    rightbelow lwindow
  else
    call win_gotoid(winid)
  endif
endfunction
" }}}} functions

" wildignore {{{{
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
" }}}} wildignore

" vim-gutentags {{{{
set tags=./.tags;,.tags
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
let g:gutentags_ctags_exclude = ['*.md', '*.json', '*.js', '*.ts', '*.jsx', '*.css', '*.less', '*.sass', '*.go', '*.dart', 'node_modules', 'dist', 'vendor']
" }}}} vim-gutentags

" vim-highlighter {{{{
let HiSetSL = '<Nop>'
let HiFindTool = 'rg -H --color=never --no-heading --column --smart-case'
nnoremap -      <Cmd>call <SID>HiOptional('next', '-')<CR>
nnoremap _      <Cmd>call <SID>HiOptional('previous', '_')<CR>
nnoremap f-     <Cmd>call <SID>HiOptional('close', 'f-')<CR>

function s:HiOptional(cmd, key)
  if HiFind()
    exe "Hi" a:cmd
  else
    exe "normal!" a:key
  endif
endfunction
" }}}}

" go.vim {{{{
let g:go_fmt_command = "gofumpt"
" }}}} go.vim

" coc.nvim {{{{
let g:copilot_no_tab_map = v:true
let g:coc_enable_locationlist = 0
let g:coc_global_extensions = [
      \'https://github.com/rafamadriz/friendly-snippets',
      \'coc-biome',
      \'coc-dictionary',
      \'coc-ecdict',
      \'coc-eslint',
      \'coc-git',
      \'coc-go',
      \'coc-highlight',
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
      \'coc-typos',
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
" set runtimepath^=~/src/coc-delance
set runtimepath^=~/src/coc-clangd

nmap <silent> gd :call <SID>go_to_definition()<CR>
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gn <Plug>(coc-rename)
nmap <silent> ge <Plug>(coc-diagnostic-next)
nmap <silent> gA <Plug>(coc-codeaction)
nmap <silent> gl <Plug>(coc-codeaction-line)
nmap <silent> gs <Plug>(coc-codeaction-source)
nmap <silent> ga <Plug>(coc-codeaction-cursor)
nmap <silent> gk <Plug>(coc-fix-current)
nmap <silent> go <Plug>(coc-git-chunkinfo)
nmap <silent> gm <Plug>(coc-git-commit)
omap <silent> ig <Plug>(coc-git-chunk-inner)
xmap <silent> ig <Plug>(coc-git-chunk-inner)

nmap <silent> ]d <Plug>(coc-diagnostic-next)
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]s <Plug>(coc-typos-next)
nmap <silent> [s <Plug>(coc-typos-prev)
nmap <silent> z= <Plug>(coc-typos-fix)
nmap <silent> <expr> [c &diff ? '[c' : '<Plug>(coc-git-prevchunk)'
nmap <silent> <expr> ]c &diff ? ']c' : '<Plug>(coc-git-nextchunk)'
nmap <silent> <M-d> <Plug>(coc-cursors-word)
xmap <silent> <M-d> <Plug>(coc-cursors-range)

nmap <leader>l  <Plug>(coc-openlink)
nmap <leader>c  <Plug>(coc-codelens-action)
nmap <leader>rf <Plug>(coc-refactor)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

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

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <backspace> coc#pum#visible() ? "\<bs>\<c-r>=coc#start()\<CR>" : "\<bs>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ <SID>next_char_pair() ? "\<Right>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent><nowait> <space>a  :call <SID>coc_qf_diagnostic()<CR>
nnoremap <silent><nowait> <space>o  :<C-u>CocList -A outline -kind<CR>
nnoremap <silent><nowait> <space>m  :<C-u>CocList -A -N mru<CR>
nnoremap <silent><nowait> <space>w  :<C-u>CocList -I -N symbols<CR>
nnoremap <silent><nowait> <space>y  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>d  :call CocActionAsync('jumpDefinition', v:false)<CR>
nnoremap <silent><nowait> <space>i  :call CocActionAsync('jumpImplementation', v:false)<CR>

" override nvim default LSP key-mappings `:h gr-default`
nnoremap <silent><nowait> gr <Plug>(coc-references-used)

imap <C-k> <Plug>(coc-snippets-expand)
vmap <C-k> <Plug>(coc-snippets-select)
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" }}}} coc.nvim

" Lua {{{{
lua <<EOF
vim.loader.enable()
require('vim.lsp.log').set_level(vim.log.levels.OFF)

require("origami").setup()

require('mini.ai').setup()
require('mini.extra').setup()
require('mini.icons').setup()
require('mini.misc').setup_restore_cursor()
require('mini.pick').setup()
require('mini.tabline').setup()
require('mini.surround').setup()
require('mini.statusline').setup()

require('hlslens').setup({ calm_down = true })
local kopts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

EOF
" }}}} Lua

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{{,}}}} foldmethod=marker foldlevel=0:
