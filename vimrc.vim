" vim: set foldmethod=marker foldlevel=0:

" mbriggs neovim config
" ======================

" ag {{{
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" }}}
" text objects {{{
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')
" }}}
" mappings {{{
let mapleader=' '
let maplocalleader=','

nmap <Leader>so <esc>:source ~/.nvim/vimrc.vim
nmap <Leader>p <esc>:CtrlP<cr>

" jump splits
map <c-j> <esc><c-w><c-w>

" toggle last file
map <Leader><Leader> <c-^>

" make toggle fold easier to hit
nmap zz za

" join in insert mode
inoremap <c-j> <esc>Ji

" save
map <c-s> :w<cr>

" alt-tab
nmap <Leader><tab> <c-^>

" close all other splits
nmap - :only<cr>

" jump to matching pair
nnoremap <Leader>m %

nmap <right> :lnext<cr>
nmap <left> :lprevious<cr>
nmap <down> :cnext<cr>
nmap <up> :cprevious<cr>

" %% for current dir
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" front and back of a line
nnoremap <s-h> ^
nnoremap <s-l> $

" up and down move the screen
nnoremap <c-s-j> <c-e>
nnoremap <c-s-k> <c-y>

"toggle spellcheck
nmap <f4> :set spell!<cr>

" why isn't it this by default??
nnoremap <s-y> y$

"resize window
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> _ :exe "resize " . (winheight(0) * 2/3)<CR>

" term stuff
tnoremap <esc> <C-\><C-n>
tnoremap <c-j> <C-\><C-n><C-w><C-w>

" }}}
" omnifuncs {{{
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" }}}
" plugins {{{
call plug#begin('~/.nvim/plugged')

Plug 'jszakmeister/vim-togglecursor'
Plug 'Shougo/deoplete.nvim'
" {{{
let g:deoplete#enable_at_startup = 1

imap <expr> ; CloseCompletionOrSemi()
func! CloseCompletionOrSemi()
  if pumvisible()
    deoplete#mappings#smart_close_popup()
  else
    return ";"
  endif
endfunc

" }}}
Plug 'alvan/vim-closetag'
Plug 'janko-m/vim-test'
Plug 'Shougo/vimfiler.vim' | Plug 'Shougo/unite.vim'
" {{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

" E edits from the local dir
nmap <silent> E :VimFiler <C-R>=expand("%:p:h") . "/"<CR><CR>
autocmd BufReadPost vimfiler set bufhidden=delete
" }}}
Plug 'ryanoasis/vim-devicons'
" {{{

" }}}
Plug 'chriskempson/base16-vim'
Plug 'mhartington/oceanic-next'
Plug 'kien/ctrlp.vim'
" {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|node_modules|tmp|bundle)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
" }}}
Plug 'Shougo/neosnippet.vim'
" {{{
let g:neosnippet#snippets_directory = $HOME.'/.nvim/snips'
let g:neosnippet#disable_runtime_snippets = {
      \   '_' : 1,
      \ }

" }}}
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-oblique' | Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-after-object'
Plug 'junegunn/vim-journal'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-eunuch'
Plug 't9md/vim-surround_custom_mapping'
" {{{
let g:surround_custom_mapping = {}
let g:surround_custom_mapping.ruby = {
            \ '-':  "<% \r %>",
            \ '=':  "<%= \r %>",
            \ '%':  "%|\r|",
            \ 'w':  "%w(\r)",
            \ '#':  "#{\r}",
            \ }
let g:surround_custom_mapping.javascript = {
            \ 'f':  "function(){ \r }"
            \ }
" }}}
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-scripts/nginx.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'
" {{{
  let g:used_javascript_libs = 'jquery'
" }}}
Plug 'ap/vim-css-color'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'zerowidth/vim-copy-as-rtf', { 'on': 'CopyRTF' }
Plug 'ngmy/vim-rubocop'
Plug 'justinmk/vim-gtfo'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
Plug 'mhinz/vim-signify'
" {{{
let g:signify_sign_add                 = "\u258F"
let g:signify_sign_delete              = "\u2581"
let g:signify_sign_delete_first_line   = "\u2594"
let g:signify_sign_change              = g:signify_sign_add
let g:signify_sign_changedelete        = g:signify_sign_add
let g:signify_vcs_list                 = ['git']
let g:signify_cursorhold_normal        = 1

set background=dark

augroup sign-column
  autocmd!
  autocmd BufEnter * call s:force_sign_col()
  function! s:force_sign_col()
    sign define dummy
    execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
  endfunction
augroup END
" }}}
Plug 'vim-ruby/vim-ruby'
Plug 'plasticboy/vim-markdown'
Plug 'honza/dockerfile.vim'
Plug 'chrisbra/unicode.vim', { 'for': 'journal' }
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
" {{{
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
" }}}
Plug 'sodapopcan/vim-twiggy'
Plug 'scrooloose/nerdtree'
" {{{
map <f1> <esc>:NERDTreeToggle<CR>
" }}}
Plug 'scrooloose/syntastic'
" {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" }}}
Plug 'rhysd/clever-f.vim'
" {{{
let g:clever_f_across_no_line = 1
" }}}
Plug 'Raimondi/delimitMate'
" {{{
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1 " {|} => { | }
" }}}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-liquid'
Plug 'esneider/YUNOcommit.vim'
Plug 'tpope/vim-fugitive'
" {{{
  " Fix broken syntax highlight in gitcommit files
  " (https://github.com/tpope/vim-git/issues/12)
  let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'

  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>ge :Gedit<CR>
  nnoremap <silent> <leader>gE :Gedit<space>
  nnoremap <silent> <leader>gr :Gread<CR>
  nnoremap <silent> <leader>gR :Gread<space>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gW :Gwrite!<CR>
  nnoremap <silent> <leader>gq :Gwq<CR>
  nnoremap <silent> <leader>gQ :Gwq!<CR>

  function! ReviewLastCommit()
    if exists('b:git_dir')
      Gtabedit HEAD^{}
      nnoremap <buffer> <silent> q :<C-U>bdelete<CR>
    else
      echo 'No git a git repository:' expand('%:p')
    endif
  endfunction
  nnoremap <silent> <leader>g` :call ReviewLastCommit()<CR>

  augroup fugitiveSettings
    autocmd!
    autocmd FileType gitcommit setlocal nolist
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
  augroup END
" }}}
Plug 'tpope/vim-dispatch'
Plug 'junegunn/vim-peekaboo'
" {{{
  let g:peekaboo_delay = 400
" }}}
Plug 'janko-m/vim-test'
" {{{
  function! TerminalSplitStrategy(cmd) abort
    tabnew | call termopen(a:cmd) | startinsert
  endfunction
  let g:test#custom_strategies = get(g:, 'test#custom_strategies', {})
  let g:test#custom_strategies.terminal_split = function('TerminalSplitStrategy')
  let test#strategy = 'terminal_split'

  nnoremap <silent> <leader>rr :TestFile<CR>
  nnoremap <silent> <leader>rf :TestNearest<CR>
  nnoremap <silent> <leader>rs :TestSuite<CR>
  nnoremap <silent> <leader>ra :TestLast<CR>
  nnoremap <silent> <leader>ro :TestVisit<CR>
" }}}
Plug 'ludovicchabant/vim-gutentags'
" {{{
  let g:gutentags_exclude = [
      \ '*.min.js',
      \ '*html*',
      \ 'jquery*.js',
      \ '*/vendor/*',
      \ '*/node_modules/*',
      \ '*/migrate/*.rb'
      \ ]
  let g:gutentags_generate_on_missing = 0
  let g:gutentags_generate_on_write = 0
  let g:gutentags_generate_on_new = 0
  nnoremap <leader>gt :GutentagsUpdate!<CR>
" }}}

call plug#end()
" }}}
" settings {{{
" colorscheme base16-eighties
colorscheme OceanicNext
set background=dark

set showcmd                               " show commands in the lower right hand corner
set backupdir=~/.nvim/backup               " save backups to .vim/backup
set directory=~/.nvim/backup               " save .swp files to .vim/backup
set undodir=~/.nvim/backup                 " persistant undo
set undofile                              " save undo info
set undolevels=1000                       " for a long time
set undoreload=10000                      " ..
filetype plugin indent on                 " load the plugin and indent settings for the detected filetype
set backspace=indent,eol,start            " allow backspacing over everything in insert mode
set laststatus=2                          " always have status bar
set wildmode=list:longest,list:full       " bash-like tab completion
set ignorecase                            " ignore case when searching
set smartcase                             " disable ignorecase when there are caps
set nowrap                                " turn off line wrapping
set tabstop=2                             " tabs are 2 spaces
set shiftwidth=2                          " >> goes 2 spaces
set softtabstop=2                         " auto tabs are 2 spaces
set autoread                              " load file if it changed on disk
set expandtab                             " spaces instead of tabs
set list listchars=tab:\ \ ,trail:.       " show leading and trailings spaces/tabs
set ruler                                 " cursor position in modeline
syntax on                                 " syntax highlighting
set novisualbell                          " turn off blinking
set history=1000                          " lots of history
set linebreak                             " wrap at word
set showtabline=2                         " always show tabs
set wrap                                  " word wrap
set showbreak=...                         " show ... at line break
set confirm                               " confirm save when leaving unsaved buffers
set foldlevelstart=99                     " turn off default folding
set wildignore+=.git,.hg,node_modules,tmp " dont search these places
set clipboard=unnamed                     " use system clipboard
set background=dark                       " use dark bg
set timeoutlen=1000 ttimeoutlen=0         " fix esc delay

set guifont=Knack\ Plus\ Nerd\ File\ Types:h18
" }}}
" auto mkdir {{{
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir)
          \   && (a:force
          \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
" }}}
" copy path {{{
nnoremap <f8> :<C-u>call <SID>copy_path()<CR>
function! s:copy_path()
  let @*=expand('%')
  let @"=expand('%')
  let @+=expand('%')
endfunction
" }}}
" tab {{{
vnoremap <tab> ==
nnoremap <tab> ==
imap <expr> <TAB>  HandleITab()
func! HandleITab()
  if neosnippet#expandable_or_jumpable()
    return "\<Plug>(neosnippet_expand_or_jump)"
  endif

  if pumvisible()
    return "\<C-n>"
  else
    return "\<ESC>==i"
  endif
endfunc
" }}}
" duping stuff {{{
func! s:DupeLine()
  normal! mpyyp`p
  call repeat#set("\<Plug>DupeLine")
endfunc

func! s:DupeVis()
  normal! mpy`>p`p
  call repeat#set("\<Plug>DupeVis")
endfunc

nmap <Plug>DupeLine :call <SID>DupeLine()<cr>
vmap <Plug>DupeVis :call <SID>DupeVis()<cr>
nmap <c-d> <Plug>DupeLine
vmap <c-d> <Plug>DupeVis
" }}}
" cr {{{
nnoremap <silent> <expr> <CR> &bt == "" ? ":nohlsearch<CR>" : "\<CR>"
" }}}
" modeline {{{
set statusline=%f       "tail of the filename

set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

set statusline+=\ \ \ %{FileSize()}

set statusline+=%#warningmsg#
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set laststatus=2


function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction


function! FileSize()
  let bytes = getfsize(expand("%:p"))
  let kb = 1024.0
  let mb = kb * 1000.0
  let gb = mb * 1000.0

  if bytes <= 0
    return ""
  endif

  if bytes > gb
    return printf('%.2f', bytes / gb) . "gb"
  endif

  if bytes > mb
    return printf('%.2f', bytes / mb) . "mb"
  endif

  if bytes > kb
    return printf('%.2f', bytes / kb) . "kb"
  endif

  return bytes
endfunction
" }}}
