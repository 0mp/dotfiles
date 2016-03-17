" .vimrc file

""      Section: Cheatsheet
"""""""""""""""""""""""""""
" Open many files at once.
"   vim -p file01 file02 *.c
"
"   :n *.c
"   :tab ball
"
" Copy text to the system clipboard.
" "*y
"
" Reload files in tabs.
" :tabdo e!
"
" Reload files in buffers.
" :bufdo e
"



""      Section: Vundle
"""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Bundle 'vim-ruby/vim-ruby'

Plugin 'ervandew/supertab'

Plugin 'scrooloose/nerdcommenter'

Plugin 'tpope/vim-repeat'

Plugin 'dahu/vim-fanfingtastic'

Plugin 'CycleColor' " Cycles through available colorschemes.

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on


" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



""      Subsection: VimRuby
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins


""      Subsection: NERDcommenter
let NERDSpaceDelims=1



""      Section: Everything
"""""""""""""""""""""""""""
" Mouse scrolling.
set mouse=a

" Jump to where I left off last time.
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal! g'\"" | endif
endif

" Make backspace work like in most other apps.
set backspace=2

set history=500
set undolevels=500

set encoding=utf-8



""      Subsection: Write and quit.
" Sudo saving.
cmap w!! w !sudo tee % >/dev/null

" :W is just as good as :w.
cmap W w

" :wq shall be responsive even if you shout.
cmap Wq wq
cmap wQ wq
cmap WQ wq

" Finally, :Q is not worse than :q, is it?
cmap Q q

" Remove trailing whitespace on file save.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()



""      Subsection: Messing with shortcuts.
" Leader needs some space.
let mapleader = " "

" Toggle paste mode.
nnoremap <leader>p :set paste!<CR>

" One clipboard is enough for me.
set clipboard=unnamed

" Shortcut for wrapping.
" cmap sw set wrap!

" Toggle wrapping.
nnoremap <leader>w :set wrap!<CR>

" Move cursor by display lines when wrapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Fight the <esc> <shift>-o delay.
set timeout timeoutlen=1000 ttimeoutlen=100



""      Subsection: Appearance customisations.
set relativenumber
set number

" Show cursor positions in the status bar.
set ruler

" Always show tabline.
set showtabline=2

" Highlight current line
set cursorline

" Cursor line in the middle.
set scrolloff=7

" Highlight the 81th column.
let &colorcolumn=0
nnoremap <leader>h :call ColorColumnToggle()<CR>
function! ColorColumnToggle()
    if &colorcolumn
        setlocal colorcolumn=0
    else
        setlocal colorcolumn=81
    endif
endfunction

" Don't let tmux mess the background colour.
" @XXX It might break some shortcuts though.
" Source: http://stackoverflow.com/questions/6427650/vim-in-tmux-background-color-changes-when-paging
if !has("gui_running")
    set term=screen-256color
    " set term=xterm
endif



""      Subsection: Files-related magic.
" Does some magic with buffers.
set hidden

" You're right Adam, no one needs it!
set nobackup
set noswapfile

" Autorefresh files.
set autoread



""		Subsection: Persistant undo history.
set undofile

" Ensure that .vimundo exists.
function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    if exists("*mkdir")
      call mkdir(a:dir,'p')
      echo "The " . a:dir . " directory for persistant undo history has been created."
    else
      echo "Please create the " . a:dir . " directory for persistant undo history manually."
    endif
  endif
endfunction

call EnsureDirExists($HOME . '/.vimundo')
set undodir=~/.vimundo/



""      Subsection: Syntax highlighting.
syntax enable
colorscheme monokai

" Well ...
nnoremap <leader><leader>hackingtime :colorscheme monochrome<CR> :echo "Hack the planet!"<CR>

" Support markdown syntax higlight for .md files.
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Show all the whitespace characters. Toggle with :set list!
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣



""      Subsection: Indentation.
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4

" Toggle between tabs and spaces.
function! TabToggle()
    if &expandtab
        set shiftwidth=8
        set tabstop=8
        set softtabstop=8
        set noexpandtab
        echo 'Using tabs for indentation from now on.'
    else
        set shiftwidth=4
        set tabstop=4
        set softtabstop=4
        set expandtab
        echo 'Using spaces for indentation from now on.'
    endif
endfunction
nnoremap <leader>t :call TabToggle()<CR>

set autoindent
set smartindent

" Round up indentation.
set shiftround



""      Subsection: Buffers
" Cycle through buffers.
nnoremap £ :bNext<CR>



""      Subsection: Searching
" Show search matches during typing.
set incsearch

" Ignore case if search pattern is all lowercase, case-sensitive otherwise.
set smartcase
set ignorecase



""      Subsection: Private mode
" Ensure private editing.
" Setup: ln -s `which vim` /symlink/name/preferably/in/your/$PATH
" Usage: Just run `vimp`.
if v:progname == "vimp"
    echo "Private mode is on!"
    colorscheme slate
    set history=0
    set nobackup
    set nomodeline
    set noshelltemp
    set noswapfile
    set noundofile
    set nowritebackup
    set secure
    set viminfo=""
endif


""      Subsection: Git
" Pull and refresh files.
fun! PullAndRefresh()
  set noconfirm
  !git pull
  bufdo e!
  set confirm
endfun

nmap <leader>gr call PullAndRefresh()
