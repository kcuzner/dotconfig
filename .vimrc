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
Plugin 'fatih/vim-go'
Plugin 'kien/ctrlp.vim'
Plugin 'wting/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'junegunn/vim-easy-align'

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

" rust ctags
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
    \]
    \}

" smart home
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set background=dark
" colorscheme jellybeans
colorscheme gruvbox

set mouse=a
syntax on
set number

set autoread

set nowrap
set sidescroll=5
set lcs=extends:>,precedes:<,tab:!.

set cc=80,120


