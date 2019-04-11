
" Vundle -------------------------------------------------------------
set nocompatible                " get out of vi-compatible mode
filetype off                    " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" languages
Plugin 'tpope/vim-commentary'

" text manipulation
Plugin 'tpope/vim-surround'

" colors
Plugin 'chriskempson/base16-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'lilydjwg/colorizer'

" navigation
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'scrooloose/nerdtree'

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

" Set title string to:
" | directory info (max 12 char) | buff. no | filename | modified | Type | Row no.
set title titlestring=...%{strpart(expand(\"%:p:h\"),stridx(expand(\"%:p:h\"),\"/\",strlen(expand(\"%:p:h\"))-12))}%=%n.\ \ %{expand(\"%:t:r\")}\ %m\ %Y\ \ \ \ %l\ of\ %L

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" vim-airline settings -----------------------------------------------
" let g:airline_theme = 'ubaryd'
" let g:airline_left_sep=''
" let g:airline_left_alt_sep='|'
" let g:airline_right_sep=''
" let g:airline_right_alt_sep='|'
" let g:airline_section_z=''
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#right_sep = ' '
" let g:airline#extensions#tabline#right_alt_sep = '|'
" let g:airline#extensions#tabline#enabled = 1
" function! AirlineInit()
"   let g:airline_section_a = airline#section#create(['mode','branch'])
"   let g:airline_section_b = airline#section#create_left(['%f%m'])
"   let g:airline_section_c = airline#section#create(['filetype'])
"   let g:airline_section_x = airline#section#create(['ffenc'])
"   " let g:airline_section_y = airline#section#create(['%B'])
"   let g:airline_section_z = airline#section#create_right(['%p%%','L: %l','C: %c'])
" endfunction
" autocmd VimEnter * call AirlineInit()


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


" Colors -------------------------------------------------------------
set t_Co=256                    " force 256 colors
let base16colorspace=256        " access colors present in 256 colorspace
" colorscheme base16-ashes
set background=light

let g:rehash256=1
" let g:sh_indent_case_labels=1

" overwrite base16-vim setting for transparent background
highlight Normal ctermbg=NONE


set noswapfile

" Look and feel ------------------------------------------------------
" set textwidth=80
set wrapmargin=2
set autoread                    " set to auto read when file changed from the outside
set number                      " show line numbers
" set relativenumber              " use relative line numbers
set norelativenumber
" set nowrap                      " disable wrapping
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
set omnifunc=ccomplete#Complete " we use C god damnit


set showcmd     " show command on last line of screen (as they're being input)
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


" Keybindings --------------------------------------------------------
set pastetoggle=<F2>            " F2 to toggle paste mode
let mapleader = "\<Space>"

" move between windows with CTL + {h,j,k,l}
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Jump to start and end of line using [F]ront and [R]ear
noremap F ^
noremap R $

" move up/down on a wrapped line with k and l
"nnoremap k gj
"nnoremap l gk

" do things right / turn off arrow keys
nnoremap <up> k 
nnoremap <down> j
nnoremap <left> h
nnoremap <right> l

" clear search highlight with <space><space>
nnoremap <leader><space> :noh<cr>

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

" switch to normal mode with jj
inoremap jj <ESC>

" remap to normal home keys
noremap k k
noremap j j
noremap h h
noremap l l

" Alt-right/left to navigate forward/backward in the tags stack
map <C-F> <C-T>
" map <M-]> <C-]>

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

function! RangeSearch(direction)
  call inputsave()
  let g:srchstr = input(a:direction)
  call inputrestore()
  if strlen(g:srchstr) > 0
    let g:srchstr = g:srchstr.
          \ '\%>'.(line("'<")-1).'l'.
          \ '\%<'.(line("'>")+1).'l'
  else
    let g:srchstr = ''
  endif
endfunction
vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>

autocmd bufreadpre *.txt setlocal textwidth=70
autocmd bufreadpre *.tex setlocal textwidth=70
autocmd bufreadpre *.c setlocal textwidth=70
autocmd bufreadpre *.h setlocal textwidth=70
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()
autocmd bufreadpre *.gnu set commentstring=#\ %s
