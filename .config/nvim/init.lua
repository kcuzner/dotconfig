vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")
vim.cmd("source ~/.vimrc")

-- Use system python, bypassing pyenv
vim.g.python3_host_prog = "/usr/bin/python3"

-- Neovide transparency
vim.g.neovide_opacity = 0.9

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
vim.keymap.set("n", "<leader>o", function () -- o for open files
  MiniPick.builtin.buffers()
end)
vim.keymap.set("n", "<leader>t", function () -- t for tags
  local taglist = vim.fn.taglist("/*")
  local last_tag = nil
  local count = 1
  for i, v in ipairs(taglist) do
    if last_tag ~= v.name then
      count = 1
    else
      count = count + 1
    end
    last_tag = v.name
    taglist[i] = { text=string.format("%s [%s]", v.name, v.filename), tag=v, matchnr = count }
  end
  opts = { source = {
    items = taglist,
    choose = function(item)
      -- I'd love to just use the tag command, but that wouldn't reflect the
      -- tag we've selected (if there are multiple matches for the tag).
      -- Instead, we manually implement the move to the tag.
      -- I'll also note that I had trouble getting getpos to work properly
      -- using the minipick state so instead we run this function after
      -- minipick has completed.
      vim.schedule(function ()
        local target = vim.fn.win_getid()
        local curpos = vim.fn.getpos('.')
        curpos[1] = vim.fn.bufnr()
        local entry = {
          bufnr = curpos[1],
          from = curpos,
          matchnr = item.matchnr,
          tagname = item.tag.name
        }
        local bufnr = vim.fn.bufadd(vim.fn.fnamemodify(item.tag.filename, ":."))
        vim.api.nvim_win_set_buf(target, bufnr)
        local stack = vim.fn.gettagstack(targe)
        stack.items = {entry}
        local s = nil
        vim.api.nvim_win_call(target, function ()
          vim.cmd(item.tag.cmd)
          vim.cmd("noh")
          assert(vim.fn.settagstack(target, stack, 't') == 0)
          s = vim.fn.gettagstack()
        end)
      end)
    end
  } }
  return MiniPick.start(opts)
end)
-- Need to ignore case for this to work right
vim.opt.ignorecase = true
