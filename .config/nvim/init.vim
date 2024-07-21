set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" Use system python, bypassing pyenv
let g:python3_host_prog = "/usr/bin/python3"
