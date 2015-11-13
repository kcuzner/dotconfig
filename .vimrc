set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'rking/ag.vim'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required

set laststatus=2 "airline

" open NERDTRee automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" show hidden files in nerdtree
let NERDTreeShowHidden=1

" tagbar
nmap <F8> :TagbarToggle<CR>

" buffer setup
set hidden
nmap <leader>T :enew<CR>
nmap <leader>[ :bp<CR>
nmap <leader>] :bn<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" autocomplete
let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1, 'python':1 }

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set background=dark
colorscheme jellybeans

set mouse=a
syntax on
set number

set nowrap
set sidescroll=5
set lcs=extends:>,precedes:<

set cc=80


