vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")
vim.cmd("source ~/.vimrc")

-- Use system python, bypassing pyenv
vim.g.python3_host_prog = "/usr/bin/python3"

-- MiniFiles setup:
--   Mapped to <leader>f
require('mini.files').setup()
vim.keymap.set("n", "<leader>f", MiniFiles.open)
