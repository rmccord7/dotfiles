" Use Vim mode
if !has('nvim')
    set nocompatible
endif
set nomodeline

" Set encoding
if !has('nvim')
    set enc=utf-8
endif

" Load any possible pre-configs (disabling YCM for example)
if filereadable(expand("~/.vimrc.before"))
    source ~/.vimrc.before
endif

" Load plugins
if filereadable(expand("~/.vim/plugs.vim"))
    source ~/.vim/plugs.vim
endif

filetype plugin indent on

" Dark terminals FTW
if !has('nvim')
    set background=dark
endif

" Always show the status line
set laststatus=2

" Set up default formatting options
set nowrap
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

if !has('nvim')
    set autoindent
endif

" Smarter backspace
set backspace=indent,eol,start

" Create quick controls for cycling buffers
map <C-n> :bn<CR>
map <c-m> :bp<CR>

" Allow switching off a modified buffer
set hidden

" Configure search options
set ignorecase
set smartcase

if !has('nvim')
    set hlsearch
    set incsearch
endif

" Map to remove search highlights
map <silent> <C-h> :nohl<CR>

" Map jk/kj to <esc>. Note that this causes small visual pauses when actually
" typing j or k
inoremap jk <ESC>
inoremap kj <ESC>

" Show highlight tabs and trailing spaces
if !has('nvim')
    set list listchars=tab:\ \ ,trail:·
endif

" Now load plugin and local settings
if filereadable(expand('~/.vim/settings.vim'))
    source ~/.vim/settings.vim
endif
