set title
set hidden
set number
set expandtab
set tabstop=4
set shiftwidth=8
set noexpandtab
set nofoldenable
set showmatch
set matchtime=2
set matchpairs+=<:>
set ignorecase
set smartcase
set switchbuf=useopen,usetab,newtab
set updatetime=100
set noshowmode
set completeopt=menu
set cmdheight=2
set foldmethod=expr
set formatexpr=CocActionAsync('formatSelected')
set tagfunc=CocTagFunc
set shortmess+=c
set pumheight=20
set nocompatible
set formatoptions=croqnlj
set backspace=indent,eol,start
" set clipboard=unnamed
set list listchars=tab:\›\ ,trail:·,eol:¬,leadmultispace:---+,nbsp:⍽,extends:>,precedes:<
setlocal noswapfile
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set runtimepath^=~/.local/share/nvim/plugged/coc.nvim
set runtimepath^=~/.local/share/nvim/plugged/catppuccin
set runtimepath^=~/.local/share/nvim/plugged/vim-sleuth
syntax on
set termguicolors
colorscheme catppuccin

set runtimepath^=~/src/coc-rust-analyzer
set runtimepath^=~/src/coc-pyright
" set runtimepath^=~/src/coc-pylance
set runtimepath^=~/src/coc-clangd

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
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<End>"

" command line mappings
cnoremap <C-a> <Home>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>

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

command! -nargs=0 JSONPretty    %!python -m json.tool
command! -nargs=0 Todos         CocList -A --normal grep -e TODO|FIXME
command! -nargs=0 Status        CocList -A --normal gstatus
command! -nargs=+ Find          exe 'CocList -A --normal grep --smart-case '.<q-args>
command! -nargs=0 Format        call CocAction('format')
command! -nargs=0 Fold          call CocAction('fold')
command! -nargs=0 GitChunkUndo  call CocAction('runCommand', 'git.chunkUndo')
command! -nargs=0 OR            call CocAction('runCommand', 'editor.action.organizeImport')

nmap <silent> gd :call <SID>go_to_definition()<CR>
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn <Plug>(coc-rename)
nmap <silent> ge <Plug>(coc-diagnostic-next)
nmap <silent> gA <Plug>(coc-codeaction)
nmap <silent> gl <Plug>(coc-codeaction-line)
nmap <silent> ga <Plug>(coc-codeaction-cursor)
nmap <silent> gs <Plug>(coc-fix-current)
nmap <silent> gk <Plug>(coc-git-chunkinfo)
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

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <backspace> coc#pum#visible() ? "\<bs>\<c-r>=coc#start()\<CR>" : "\<bs>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1):
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent><nowait> <space>f  :<C-u>CocList files<CR>
nnoremap <silent><nowait> <space>o  :<C-u>CocList -A outline -kind<CR>
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<CR>
nnoremap <silent><nowait> <space>l  :<C-u>CocList lines<CR>
nnoremap <silent><nowait> <space>q  :<C-u>CocList quickfix<CR>
nnoremap <silent><nowait> <space>w  :<C-u>CocList -I -N symbols<CR>
nnoremap <silent><nowait> <space>y  :<C-u>CocList -A --normal yank<CR>
nnoremap <silent><nowait> <space>b  :<C-u>CocList -A -N --normal buffers<CR>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>s  :exe 'CocList -I --normal --input='.expand('<cword>').' grep'<CR>
nnoremap <silent><nowait> <space>S  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
nnoremap <silent><nowait> <space>d  :call CocActionAsync('jumpDefinition', v:false)<CR>

imap <C-k> <Plug>(coc-snippets-expand)
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

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

function! s:go_to_definition()
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
" }} functions

augroup common
  autocmd!
  autocmd BufNewFile,BufReadPost *.md setfiletype markdown
  autocmd BufNewFile,BufReadPost *.tsx setfiletype typescript.tsx
  autocmd BufNewFile,BufReadPost *.jsx setfiletype javascript.jsx
  autocmd BufNewFile,BufReadPost *.jl setfiletype julia
  autocmd BufNewFile,BufReadPost *.re setfiletype rescript

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

  " set up default omnifunc
  autocmd FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup end
