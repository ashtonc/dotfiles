" vundle
set nocompatible
filetype off

set rtp +=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'sonph/onehalf', {'rtp': 'vim/'}

call vundle#end()
filetype plugin indent on

colorscheme onehalflight
let g:airline_theme='onehalfdark'

" Line numbering
set number

" Line wrapping
set wrap

" Whitespace
set textwidth=0
set wrapmargin=0
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab

" Encoding
set encoding=utf-8

" Blink instead of beeping
set visualbell

" Show file information
set ruler
set showmode
set showcmd
set laststatus=2

" Search highlighting
set hlsearch

" Color scheme
syntax enable
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Swap file location
set directory=$HOME/.vim/swapfiles//
set backupdir=$HOME/.vim/backups//

