" .vimrc file



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



""      Subsection: Messing with shortcuts.
" Leader needs some space.
let mapleader = " "

" Toggle paste mode.
nnoremap <leader>p :set paste!<CR>

" Shortcut for wrapping.
cmap sw set wrap!



""      Subsection: Appearance customisations.
set number
" Show cursor positions in the status bar.
set ruler

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



""      Subsection: Files-related magic.
" Does some magic with buffers.
set hidden

" You're right Adam, no one needs it!
set nobackup
set noswapfile



""      Subsection: Syntax highlighting.
syntax enable
colorscheme monokai

" Support markdown syntax higlight for .md files.
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown



""      Subsection: Indentation.
set shiftwidth=4
set tabstop=4
set expandtab

" Toggle between tabs and spaces.
function! TabToggle()
  if &expandtab
    set shiftwidth=8
    set tabstop=8
    set noexpandtab
  else
    set shiftwidth=4
    set tabstop=4
    set expandtab
  endif
endfunction
nnoremap <leader>t :call TabToggle()<CR>

set autoindent
set smartindent

" Round up indentation.
set shiftround



""      Subsection Searching
" Show search matches during typing.
set incsearch

" Ignore case if search pattern is all lowercase, case-sensitive otherwise.
set smartcase

