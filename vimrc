" http://nvie.com/posts/how-i-boosted-my-vim/
" http://items.sjbach.com/319/configuring-vim-right
set nocompatible
set hlsearch        " highlight search terms
set incsearch       " search as you type
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search is all lowercase
set cindent
set number          " show line numbers
set linebreak
set tabstop=2
set softtabstop=2
set shiftwidth=2
"set smarttab        " insert tabs on start of line based on shiftwidth not tabstop
set expandtab
set guifont=Menlo:h12
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
" call pathogen#helptags_all_bundles()
call pathogen#runtime_append_all_bundles()

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
set clipboard=unnamed

if has('autocmd')
  autocmd filetype python set expandtab
endif

" No tooltips
if exists('+ballooneval')
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

" Hide search highlighting when redrawing screen
nnoremap <leader><space> :nohls<cr>

" Sane regex
nnoremap / /\v
vnoremap / /\v

" j and k should navigate screen-wise, not file wise
nnoremap j gj
nnoremap k gk

" Speed up scrolling with ^e,^y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Window navigating
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" The following will make whitespace visible when requested: 
nnoremap <leader>l :set nolist!<CR>

" From http://vimcasts.org/episodes/indentation-commands/
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" From the cmdline help page - ex cmdline key bindings
:cnoremap <C-A> <Home>
:cnoremap <C-F> <Right>
:cnoremap <C-B> <Left>
:cnoremap <Esc>b <S-Left>
:cnoremap <Esc>f <S-Right>

" From http://github.com/namedpipe/fuzzyfinder_textmate
nnoremap <unique> <leader>f :FuzzyFinderTextMate<CR>
nnoremap <unique> <leader>t :TlistToggle<CR>
nnoremap <unique> <leader>n :NERDTreeToggle<CR>
map <unique> <silent> <Leader>z <Plug>SimpleFold_Foldsearch
"nnoremap <leader>b :TMiniBufExplorer<CR>


"""""""""""""""""""""""""""""""""
" Plugin options
"""""""""""""""""""""""""""""""""

" MiniBufferExplorer
"let g:miniBufExplorerMoreThanOne = 20     " don't open miniBufExplorer until there are many buffers
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplMapCTabSwitchBufs = 1

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
