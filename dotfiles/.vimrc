" Detect os and store it in global variable.
" Possible values include "Windows", "Linux", "Darwin"
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" __     __               _ _
" \ \   / /   _ _ __   __| | | ___
"  \ \ / / | | | '_ \ / _` | |/ _ \
"   \ V /| |_| | | | | (_| | |  __/
"    \_/  \__,_|_| |_|\__,_|_|\___|
"
"  FIGLET: Vundle

set nocompatible                " get out of vi-compatible mode
filetype off                    " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" text manipulation
Plugin 'tpope/vim-surround'                     " new surround motion bound to s
Plugin 'tpope/vim-commentary'                   " gc to comment
"  context-aware pasting
Plugin 'sickill/vim-pasta'
Plugin 'SirVer/ultisnips'                       " snippets engine

" colors
Plugin 'chriskempson/base16-vim'
" Plugin 'itchyny/lightline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'srcery-colors/srcery-vim'
Plugin 'rakr/vim-one'
Plugin 'challenger-deep-theme/vim'
Plugin 'morhetz/gruvbox'
Plugin 'nanotech/jellybeans.vim'

" navigation
" Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'                     " Ctrl+p to fuzzy search files
Plugin 'easymotion/vim-easymotion'              " Vim motions on speed!

" other utilities
Plugin 'xolox/vim-misc'
Plugin 'tmux-plugins/vim-tmux-focus-events'
" Plugin 'christoomey/vim-tmux-navigator'
Plugin 'bgr360/vim-tmux-navigator'
Plugin 'tpope/vim-repeat'                       " Repeatable custom mappings
Plugin 'skywind3000/asyncrun.vim'               " AsyncRun function
Plugin 'xolox/vim-session'                      " Create named sessions
Plugin 'Vimjas/vim-python-pep8-indent'          " Python indentation
Plugin 'triglav/vim-visual-increment'		" Increment numbers in columns
" TODO Plugin 'benmills/vimux'
" https://raw.githubusercontent.com/benmills/vimux/master/doc/vimux.txt

" Local vimrc support (override ~/.vimrc with a _vimrc_local.vim" file)
Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/local_vimrc'

Plugin 'Shougo/deoplete.nvim'                   " Autocompletion
" Required for deoplete
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'


" searching
Plugin 'mileszs/ack.vim'                       " used to invoke ag for grepping


call vundle#end()       " required
syntax on
filetype plugin on      " required
filetype indent on      " required




" __     ___
" \ \   / (_)_ __ ___  _ __ ___
"  \ \ / /| | '_ ` _ \| '__/ __|
"   \ V / | | | | | | | | | (__
"    \_/  |_|_| |_| |_|_|  \___|
"
"  FIGLET: Vimrc
" -----------------------------------------------------------------------------


let mapleader = "\<Space>"

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
" let g:Powerline_symbols = 'fancy'
" let g:lightline = {
" 	\ 'colorscheme': 'gruvbox',
" 	\ }

" airline settings ---------------------------------------------------
let g:airline_powerline_fonts = 1


" ctrlp settings ----------------------------------------------------

let g:ctrlp_match_window = 'results:100'
" Delay completion until typing stops for this many milliseconds
let g:ctrlp_lazy_update = 250
" Open a file in existing buffer when <cr> pressed, but only if in current tab
let g:ctrlp_switch_buffer = 'e'

" ack settings -------------------------------------------------------

" use ag if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" deoplete settings --------------------------------------------------
" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete', 1)
call deoplete#custom#option('auto_complete_delay', 100)
call deoplete#custom#option('max_list', 25)
call deoplete#custom#option('refresh_always', 0)
call deoplete#custom#option('smart_case', v:true)


" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" easymotion keybindings ---------------------------------------------

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f2)
" Remap f to be bidirectional character find on one line
nmap f <Plug>(easymotion-bd-fl)
" Do the same with t
nmap t <Plug>(easymotion-bd-tl)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1


" vim-session settings -----------------------------------------------
let g:session_autoload = 'no'
let g:session_autosave = 'yes'

nnoremap <leader><C-o> :OpenSession<CR>


" ultisnips settings -------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-v>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']


" nerdtree settings --------------------------------------------------

" Control-n to open NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter *
      \ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
      \   exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] |
      \ endif


"  _____ _
" |_   _(_)_ __  ___
"   | | | | '_ \/ __|
"   | | | | |_) \__ \
"   |_| |_| .__/|___/
"         |_|
"
" FIGLET: Tips

" Marks:
" Use m to set a mark.
" ` to return exactly to that mark
" ' to return to the line of that mark
"
" Handy built in marks:
" '< & '> start/end of visual selection
" '[ & '] - start/end of last change or yank
" '. - position of where last change was made
" '^ - position of cursor when last Vim last left insert mode - This is how gi command works
" '' - position before last jump (Super useful!). See :h ''
"
" Navigating between marks:
" ]' jump to next line with a lowercase mark
" [' jump to previous line with a lowercase mark
" ]` jump to next lowercase mark
" [` jump to previous lowercase mark


"   ____                           _
"  / ___| ___ _ __   ___ _ __ __ _| |
" | |  _ / _ \ '_ \ / _ \ '__/ _` | |
" | |_| |  __/ | | |  __/ | | (_| | |
"  \____|\___|_| |_|\___|_|  \__,_|_|
"
" FIGLET: General

set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos
set noswapfile

" Some sort of whack for YouCompleteMe
set shortmess+=c

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us

" Colors -------------------------------------------------------------
set t_Co=256                    " force 256 colors
"let base16colorspace=256        " access colors present in 256 colorspace
" colorscheme desert
colorscheme gruvbox
set background=dark

" let g:rehash256=1
let g:sh_indent_case_labels=1

" overwrite base16-vim setting for transparent background
"highlight Normal ctermbg=NONE

" Look and feel ------------------------------------------------------
set wrapmargin=2
set autoread
set number relativenumber       " show line numbers
set wrap                        " enable line wrapping
set tw=0                        " do not automatically wrap words while typing
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
set laststatus=2                " always display statusbar
set showmatch                   " highlight matching brackets
set matchtime=2                 " tenths of a second to blink matching brackets

set hlsearch                    " highlight all search matches
set incsearch                   " start highlighting before hitting 'enter'
set ignorecase                  " perform case-insensitive search
set smartcase                   " ...unless search term has a capital letter

set nostartofline               " leave cursor where it was
set nocursorline                " try to speed up scrolling
set report=0                    " report back all changes
set ruler                       " always show current positions along the bottom

" show command on last line of screen (as they're being input)
set showcmd
set showmode

set clipboard=unnamed           " for clipboard to work nicely on osx

noh                             " don't highlight things when reloading vimrc

" visual autocomplete for command menu
set wildmode=longest,list,full
set wildmenu
set completeopt=menu,menuone,longest,preview

set splitright                  " split windows to right
set splitbelow                  " split windows to bottom

" Don't automatically continue comments when I insert a line below a comment
autocmd FileType * setlocal formatoptions-=o

" Yanking in visual mode:
"   y : yank text, place cursor at end of selection
"   Y : yank text, place cursor at beginning of selection
vnoremap y y']
vnoremap Y y'[
" Note: the default behavior for Y in vmode is to 'select lines'
" (as opposed to 'select text'). I'm fine with overriding this.
" If I want to select lines, I always enter visual line mode.

" File types ---------------------------------------------------------

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Tab behavior -------------------------------------------------------
set autoindent                  " set cursor at same indent
set smartindent                 " autoindent
set noexpandtab                 " dont use spaces instead of tabs
set shiftwidth=8                " tab width = 8 spaces
set tabstop=8                   " spaces for <Tab>

" Misc ---------------------------------------------------------------
let g:is_bash = 1		" Who writes POSIX shell scripts?




"  _                   _
" | |    ___  __ _  __| | ___ _ __
" | |   / _ \/ _` |/ _` |/ _ \ '__|
" | |__|  __/ (_| | (_| |  __/ |
" |_____\___|\__,_|\__,_|\___|_|
"  __  __                   _
" |  \/  | __ _ _ __  _ __ (_)_ __   __ _ ___
" | |\/| |/ _` | '_ \| '_ \| | '_ \ / _` / __|
" | |  | | (_| | |_) | |_) | | | | | (_| \__ \
" |_|  |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"              |_|   |_|            |___/
"
" FIGLET: Leader Mappings

" clear search highlight with <space><space>
nnoremap <leader><space> :noh<cr>

" get help on current word/selection with <leader>h
nnoremap <leader>h :help <C-r><C-w><CR>
vnoremap <leader>h "vygv:<C-u>help <C-r>v<CR>

" reload the vimrc with <leader>r
nnoremap <leader>r :source $MYVIMRC<cr>

" <leader>-o to insert a line below and move cursor to next line
" <leader>-O to insert a line above and move cursor to prev line
" <leader>-l to insert a line below and leave cursor
" <leader>-L to insert a line above and leave cursor
nnoremap <silent> <leader>o o<ESC>
nnoremap <silent> <leader>O O<ESC>
nnoremap <expr> <leader>l "mM:call BlankDown(" . v:count1 . ")\<cr>"
nnoremap <expr> <leader>L "mM:call BlankUp(" . v:count1 . ")\<cr>"

" Pasting:
" Both of these will:
"   1. Enable paste mode
"   2. Enter insert mode (either on next or current line)
"   3. Automatically disable paste mode upon leaving insert mode
" <leader>-p to enable paste, enter insert mode on *next* line
nnoremap <silent> <leader>p :call <sid>setup_paste()<CR>o
" <leader>-P to enable paste, enter insert mode on *current* line
nnoremap <silent> <leader>P :call <sid>setup_paste()<CR>i

" LaTeX:
" <leader>-be to begin enumerate
nnoremap <silent> <leader>be i\begin{enumerate}<CR>\end{enumerate}<ESC>O
xmap     <silent> <leader>be S\begin{enumerate}<CR>
" <leader>-bi to begin itemize
nnoremap <silent> <leader>bi i\begin{itemize}<CR>\end{itemize}<ESC>O
xmap     <silent> <leader>bi S\begin{itemize}<CR>
" <leader>-bv to begin verbatim
nnoremap <silent> <leader>bv i\begin{verbatim}<CR>\end{verbatim}<ESC>O
xmap     <silent> <leader>bv S\begin{verbatim}<CR>
" <leader>-it to textit{}
nmap     <leader>it ysiW\textit<CR>
vmap     <leader>it S\textit<CR>
" <leader>-bf to textbf{}
nmap     <leader>bf ysiW\textbf<CR>
vmap     <leader>bf S\textbf<CR>
" <leader>-tt to texttt{}
nnoremap <silent> <Plug>BenVimrcEscapeLatex f{v%:s/\(_\\|&\)/\\\1/g<CR>:noh<CR>`<B
nmap     <leader>tt ysiW\texttt<CR>:execute "normal \<Plug>BenVimrcEscapeLatex"<CR>
vmap     <leader>tt S\texttt<CR>:execute "normal \<Plug>BenVimrcEscapeLatex"<CR>

" Editing:
" <leader>-in to increment a column of numbers
"    e.g.   10         10
"           10   -->   11
"           10         12
vmap <silent> <leader>in <Plug>VisualIncrement


"  _  __          _     _           _ _
" | |/ /___ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
" | ' // _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
" | . \  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
" |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
"           |___/                             |___/
"
" FIGLET: Keybindings

" Rebind ; to : (fewer keystrokes)
nnoremap ; :
vnoremap ; :

" Since I remapped ;
" Default motion repeat for tTfF is ; (forward) and , (backward)
" Remap , to forward and Shift+, to backward.
nnoremap < ,
vnoremap < ,
nnoremap , ;
vnoremap , ;

" switch to normal mode with jj
inoremap jj <ESC>
inoremap JJ <ESC>
" also from inside command mode
cnoremap jj <C-c>
cnoremap JJ <C-c>

" remap Ctrl+j/k to navigate back and forth through the command history
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" Jump to start and end of line using H and L
noremap H ^
noremap L $

" move up/down on a wrapped line with k and j
" but still work correctly with counts
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'

" I don't fucking want to join lines usually!!
nnoremap J j
vnoremap J j

" But sometimes I do... so use <leader>J for that
nnoremap <leader>J J
vnoremap <leader>J J

" Removes doc lookup mapping because it's easy to fat finger and never useful.
nnoremap K k
vnoremap K k

" Shift-J and Shift-K to move up and down a little faster
noremap J 4j
noremap K 4k

" move line mappings
" ∆ is <A-j> on macOS
" ˚ is <A-k> on macOS
nnoremap ∆ :m .+1<cr>==
nnoremap ˚ :m .-2<cr>==
inoremap ∆ <Esc>:m .+1<cr>==gi
inoremap ˚ <Esc>:m .-2<cr>==gi
vnoremap ∆ :m '>+1<cr>gv=gv
vnoremap ˚ :m '<-2<cr>gv=gv

" More natural window switching
" Integrated with vim-tmux-navigator
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" More natural split creation.
" Press Ctrl-W then capital H J K or L to create new split.
nnoremap <C-w>H :leftabove  vsplit<cr>
nnoremap <C-w>J :rightbelow split<cr>
nnoremap <C-w>K :leftabove  split<cr>
nnoremap <C-w>L :rightbelow vsplit<cr>

" More natural tab navigation / creation with <C-R> as prefix
nnoremap <C-r>r :tabnew<cr>
nnoremap <C-r>w :tabclose<cr>
nnoremap <C-r>h :tabprev<cr>
nnoremap <C-r>l :tabnext<cr>
nnoremap <C-r>j :tabfirst<cr>
nnoremap <C-r>k :tablast<cr>

" Hit Ctrl-R + <num> to switch to that tab
for i in range(1,9)
  execute "nnoremap <C-r>" . i . " " . i . "gt<cr>"
endfor

" By default, <C-F> and <C-B> scroll down and up pages
" and <C-D> and <C-U> scroll up and down by half pages.
" This makes <C-F> and <C-D> go down and up by pages.
noremap <C-F> <C-D>
noremap <C-D> <C-U>

" Make Y behave like other capital commands.
" Hat-tip http://vimbits.com/bits/11
nnoremap Y y$

" remap U to <C-r> for easier redo
" from http://vimbits.com/bits/356
nnoremap U <C-r>

" Press '? to list all marks
nnoremap '? :marks<CR>
vnoremap '? :marks<CR>

" Press "? to list all register content
nnoremap "? :registers<CR>
vnoremap "? :registers<CR>

" Don't move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Use sane/perl-like regular expressions
nnoremap / /\v
vnoremap / /\v

" no one ever hits F1 on purpose
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" for some reason my deindenting in visual mode is fucky. trying to fix it:
vnoremap <silent> < :<<CR>

" Handy shortcut in insert mode for autocompleting entire lines.
" Opens line complete (<C-x><C-l>) and goes to most recent in list (<C-p>).
inoremap <C-l> <C-x><C-l><C-p>


"  _____                 _   _
" |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
" | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
" |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
" |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
"
"  FIGLET: Functions

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
" cs add $CSCOPE_DB

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

" Sets paste and automatically unsets paste when you exit insert mode
function! s:setup_paste() abort
  let s:paste = &paste
  let s:mouse = &mouse
  set paste
  set mouse=
  augroup unimpaired_paste
    autocmd!
    autocmd InsertLeave *
          \ if exists('s:paste') |
          \   let &paste = s:paste |
          \   let &mouse = s:mouse |
          \   unlet s:paste |
          \   unlet s:mouse |
          \ endif |
          \ autocmd! unimpaired_paste
  augroup END
endfunction

" Insert a blank line on the line above
function! BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
endfunction

" Insert a blank line on the line below
function! BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
endfunction

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            " let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum TabLineSel
endif
