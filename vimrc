" http://nvie.com/posts/how-i-boosted-my-vim/
" http://items.sjbach.com/319/configuring-vim-right
set nocompatible
set hlsearch        " highlight search terms
set incsearch       " search as you type
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search is all lowercase
set number          " show line numbers
set linebreak
set tabstop=2
set softtabstop=2
set shiftwidth=2
"set smarttab        " insert tabs on start of line based on shiftwidth not tabstop
set expandtab
set guifont=Menlo:h12
set cindent         " smart inent new lines: smartindent is a similar option that is less strict
set autoindent
set copyindent
set showmatch       " show matching parentheses
set hidden          " handle multiple buffers better
set wildmenu        " better tab completion for files
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class
set history=1000
set ruler
set backspace=indent,eol,start
set listchars=tab:>\ ,trail:·,eol:$,nbsp:·,extends:#
" set relativenumber " shows relative line numbers

" Allows per plugin directories, needs to be before `filetype plugin indent on'
call pathogen#infect()

" % will match more than just brackets
runtime macros/matchit.vim

" Put temp files in one place
"set backupdir=~/.vim-tmp,/tmp
"set directory=~/.vim-tmp,/tmp
"set backupskip+=/Volumes/Crypt
set nobackup
set noswapfile

syntax on
filetype on
filetype plugin on
filetype indent on

" http://stackoverflow.com/questions/677986/vim-copy-selection-to-os-x-clipboard
"set clipboard=unnamed

if has('autocmd')
  autocmd filetype python set expandtab
  
  " Show trailing whitepace and spaces before a tab:
  "autocmd Syntax * syn match Error /\s\+$\| \+\ze\t/
endif

" No tooltips
"if exists('+ballooneval')
if has('balloon_eval')
  set noballooneval
endif

" hide toolbar
if has("gui_running")
  set guioptions-=T
endif

" from http://www.linux.com/archive/feature/114138
" save folds when closing, restore folds on open
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview


"""""""""""""""""""""""""""""""""
" Keyboard Re-mappings
"""""""""""""""""""""""""""""""""

" Sane regex
nnoremap / /\v
vnoremap / /\v

" j and k should navigate screen-wise, not file wise
nnoremap j gj
nnoremap k gk

nnoremap Y y$

" Speed up scrolling with ^e,^y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Window navigating
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" From http://vimcasts.org/episodes/indentation-commands/
"nmap <D-[> <<
"nmap <D-]> >>
"vmap <D-[> <gv
"vmap <D-]> >gv

" From the cmdline help page - ex cmdline key bindings
cmap <C-A> <Home>
cmap <C-F> <Right>
cmap <C-B> <Left>
cmap <Esc>b <S-Left>
cmap <Esc>f <S-Right>
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" From http://github.com/namedpipe/fuzzyfinder_textmate
nnoremap <unique> <leader>fc :FufCoverageFile<CR>
nnoremap <unique> <leader>fb :FufBuffer<CR>
nnoremap <unique> <leader>ff :FufFile<CR>
nnoremap <unique> <leader>tl :TlistToggle<CR>
nnoremap <unique> <leader>n :NERDTreeToggle<CR>
map <unique> <silent> <leader>z <Plug>SimpleFold_Foldsearch
noremap <unique> <leader>g :GundoToggle<CR>
"nnoremap <leader>b :TMiniBufExplorer<CR>
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
" Hide search highlighting when redrawing screen
nnoremap <leader><space> :nohls<cr>
" The following will make whitespace visible when requested: 
nnoremap <leader>l :set nolist!<CR>
map <unique> <leader># :call g:ToggleNuMode()<CR>
map <unique> <leader>w :set wrap!<CR>

"inoremap <C-A> <Home>
"inoremap <C-E> <End>
"inoremap <C-F> <Right>   " cinkeys needs to be changed too for this
"inoremap <C-B> <Left>

"""""""""""""""""""""""""""""""""
" Plugin options
"""""""""""""""""""""""""""""""""

" repmo.vim - REMOVED
"let g:repmo_mapmotions = ""

" MiniBufferExplorer
"let g:miniBufExplorerMoreThanOne = 20     " don't open miniBufExplorer until there are many buffers
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplMapCTabSwitchBufs = 1

" BufExplorer
let g:bufExplorerShowRelativePath=1

" detect indent
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 2

" Fix sql keybindings
let g:ftplugin_sql_omni_key_right = '<C-Right>'
let g:ftplugin_sql_omni_key_left  = '<C-Left>'
"let g:omni_sql_no_default_maps = 1

" Hide MyProjects at first
let g:myprojects_auto_open = 0


" From http://vim.wikia.com/wiki/Capture_ex_command_output
" Captures ex command and puts it in a new tab
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" Set ts sts sw = num
function! Tabs(num)
  let &tabstop = a:num
  let &shiftwidth = a:num
  let &softtabstop = a:num
endfunction
command! -nargs=1 Tabs call Tabs(<args>)

function! g:ToggleNuMode()
  if(&rnu == 1)
    set nu
  else
    set rnu
  endif
endfunc

" function! ShowSynStack()
"   let s:syn_stack = ''
"   for id in synstack(line("."), col("."))
"     let s:syn_stack = s:syn_stack . ' > ' . synIDattr(id, "name")
"   endfor
"   echo s:syn_stack
"   return s:syn_stack
" endfunction 
" set statusline+=%{ShowSynStack()}
" set laststatus=2
