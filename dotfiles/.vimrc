
" Vundle -------------------------------------------------------------
set nocompatible                " get out of vi-compatible mode
filetype off                    " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" languages

" text manipulation
Plugin 'tpope/vim-surround'			" new surround motion bound to s
Plugin 'tpope/vim-commentary'			" gc to comment

" colors
Plugin 'chriskempson/base16-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'lilydjwg/colorizer'

" navigation
" Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'			" Ctrl+p to fuzzy search files

" other utilities
Plugin 'xolox/vim-misc'
" Plugin 'tpope/vim-obsession'
Plugin 'tmux-plugins/vim-tmux-focus-events'

" Man page
Plugin 'vim-utils/vim-man'
Plugin 'BenBergman/vsearch.vim'

" for gnuplot
" Plugin 'vim-scripts/gnuplot-syntax-highlighting'

call vundle#end()       " required
syntax on
filetype plugin on      " required
filetype indent on      " required

nnoremap ; :
vnoremap ; :

set autoread

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" lightline settings -------------------------------------------------
let g:Powerline_symbols = 'fancy'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


" General ------------------------------------------------------------
set encoding=utf-8
set clipboard=unnamed           " share windows clipboard += windows
set fileformat=unix
set fileformats=unix,dos
set wrap
"set nobinary

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us


" Keybindings --------------------------------------------------------

" switch to normal mode with jj
inoremap jj <ESC>
inoremap JJ <ESC>

" <Space>-p to toggle paste mode (but only in normal and visual)
" set pastetoggle=<leader>p
nnoremap <space>p :set invpaste<CR>
vnoremap <space>p :set invpaste<CR>

" Jump to start and end of line using H and L
noremap H ^
noremap L $

" move up/down on a wrapped line with k and j
" but still work correctly with counts
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'

" I don't fucking want to join lines ever!!
nnoremap J j
vnoremap J j

" Removes doc lookup mapping because it's easy to fat finger and never useful.
nnoremap K k
vnoremap K k

" Shift-J and Shift-K to move up and down a little faster
noremap J 4j
noremap K 4k

" Ctrl-J to go down by pages
" Ctrl-K to go up just as fast
noremap <C-j> <C-F>
noremap <C-k> <C-B>

" Because my tmux maps Ctrl+k to clear the screen
noremap <C-l> <C-B>

" By default, <C-F> and <C-B> scroll down and up pages
" and <C-D> and <C-U> scroll up and down by half pages.
" This makes <C-F> and <C-D> go down and up by 
noremap <C-F> <C-D>
noremap <C-D> <C-U>

" Make Y behave like other capital commands.
" Hat-tip http://vimbits.com/bits/11
nnoremap Y y$

" remap U to <C-r> for easier redo
" from http://vimbits.com/bits/356
nnoremap U <C-r>

" Don't move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Use sane/perl-like regular expressions
nnoremap / /\v
vnoremap / /\v

" move around code blocks with <TAB>
nnoremap <tab> %
vnoremap <tab> %

" no one ever hits F1 on purpose
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>


" Leader Keybinds ---------------------------------------------------
let mapleader = "\<Space>"

" clear search highlight with <space><space>
nnoremap <leader><space> :noh<cr>

" get help on current word with <leader>h
nnoremap <leader>h :h <C-r><C-w><CR>


" Colors -------------------------------------------------------------
" set t_Co=256                    " force 256 colors
" let base16colorspace=256        " access colors present in 256 colorspace
" colorscheme base16-ashes
colorscheme desert

" let g:rehash256=1
" let g:sh_indent_case_labels=1

" overwrite base16-vim setting for transparent background
" highlight Normal ctermbg=NONE

" Look and feel ------------------------------------------------------
set wrapmargin=2
set autoread                    " set to auto read when file changed from the outside
set number relativenumber	" show line numbers
" set nowrap                    " disable wrapping
set mouse=c                     " disable mouse in normal/insert/command/visual
set ttyfast                     " improve scrolling speed
set nofoldenable                " disable folding
set noerrorbells                " disable bell/flash
set history=1000                " command history length
set hidden                      " don't fucking whine about unsaved buffers

set scrolloff=15                " keep 15 lines vertical for scope
set sidescrolloff=5             " keep 5 lines horizontal at the side
set sidescroll=1                " number of columns to scroll at a time
set backspace=2                 " make backspace work normally
set tabpagemax=15               " max 15 tabs open
set laststatus=2                " always display statusbar
set previewheight=20            " maximum height for preview window
set showmatch                   " highlight matching brackets
set matchtime=2                 " tenths of a second to blink matching brackets

set hlsearch                    " highlight all search matches
set incsearch                   " start search highlighting before hitting 'enter'
set ignorecase                  " perform case-insensitive search
set smartcase                   " ...unless search term has a capital letter
set gdefault                    " s///g by default

set linespace=0                 " line padding
set nostartofline               " leave cursor where it was
set nocursorline		" try to speed up scrolling
set report=0                    " report back all changes
set ruler                       " always show current positions along the bottom

set showcmd     		" show command on last line of screen (as they're being input)
set showmode

" visual autocomplete for command menu
set wildmode=longest,list,full
set wildmenu
set completeopt=menu,menuone,longest,preview

set splitright                  " split windows to right
set splitbelow                  " split windows to bottom

" Tab behavior -------------------------------------------------------
set autoindent                  " set cursor at same indent
set smartindent                 " autoindent
set noexpandtab                 " dont use spaces instead of tabs
set shiftwidth=8                " tab width = 2 spaces
set tabstop=8                   " spaces for <Tab>
set noswapfile



" Functions -------------------------------------------------
" Prevent replacing paste buffer on paste
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
cs add $CSCOPE_DB

" function! RangeSearch(direction)
"   call inputsave()
"   let g:srchstr = input(a:direction)
"   call inputrestore()
"   if strlen(g:srchstr) > 0
"     let g:srchstr = g:srchstr.
"           \ '\%>'.(line("'<")-1).'l'.
"           \ '\%<'.(line("'>")+1).'l'
"   else
"     let g:srchstr = ''
"   endif
" endfunction
" vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
" vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

" autocmd bufreadpre *.txt setlocal textwidth=70
" autocmd bufreadpre *.tex setlocal textwidth=70
" autocmd bufreadpre *.c setlocal textwidth=70
" autocmd bufreadpre *.h setlocal textwidth=70
" function! LoadCscope()
"   let db = findfile("cscope.out", ".;")
"   if (!empty(db))
"     let path = strpart(db, 0, match(db, "/cscope.out$"))
"     set nocscopeverbose " suppress 'duplicate connection' error
"     exe "cs add " . db . " " . path
"     set cscopeverbose
"   endif
" endfunction
" au BufEnter /* call LoadCscope()
" autocmd bufreadpre *.gnu set commentstring=#\ %s
