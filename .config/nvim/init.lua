vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")
vim.cmd("source ~/.vimrc")

-- Use system python, bypassing pyenv
vim.g.python3_host_prog = "/usr/bin/python3"

-- MiniFiles setup:
--   Mapped to Alt+f
require('mini.files').setup()
vim.keymap.set("n", "<M-f>", MiniFiles.open)
--   Open MiniFiles pointing at current file
vim.keymap.set("n", "<M-F>", function ()
  local _ = MiniFiles.close()
    or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  vim.schedule(function()
    MiniFiles.reveal_cwd()
  end, 30)
end)

-- I like the mini icons
require('mini.icons').setup()

-- Mini pick setup. These blap the fzf configuration
--
-- I've found this to be considerably faster than fzf
require('mini.pick').setup()
vim.keymap.set("n", "<leader>s", function ()
  MiniPick.builtin.files()
end)
vim.keymap.set("n", "<leader>S", function ()
  MiniPick.builtin.cli({ command = {"rg", "--files", "--no-ignore", "--color=never"} });
end)
-- Need to ignore case for this to work right
vim.opt.ignorecase = true
