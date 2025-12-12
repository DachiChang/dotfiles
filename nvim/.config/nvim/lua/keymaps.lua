local keymap = vim.keymap
local default_opts = { noremap = true, silent = true } -- nomap (default) 映射後直接執行 cmd
local remap_opts = { remap = true, silent = true }     -- remap 映射後會再遞回解析結果

-- NOTE: keymap mode short-name
-- n: normal
-- v: visual
-- s: select
-- x: visual line
-- i: insert
-- t: terminal
-- c: command
-- o: operator (like d, y, c, etc.)

-- Quit
keymap.set("n", "<C-q>", "<CMD>q!<CR>", default_opts)
keymap.set("n", "<LEADER>q", "<CMD>qa!<CR>", default_opts)

-- Jump
keymap.set("n", "<LEADER>\\", "<CMD>e#<CR>", default_opts)

-- Tab
keymap.set("n", "<", "<CMD>tabm -1<CR>", default_opts)
keymap.set("n", ">", "<CMD>tabm +1<CR>", default_opts)
keymap.set("n", "<C-n>", "<CMD>tabnext<CR>", default_opts)
keymap.set("n", "<C-p>", "<CMD>tabprev<CR>", default_opts)
keymap.set("n", "<C-t>", "<CMD>tabnew<CR>", default_opts)

-- Functional
keymap.set("n", "<F5>", "<CMD>e!<CR>", default_opts)

-- Window
keymap.set("n", "=", "<C-w>=", default_opts)
keymap.set("n", "<C-x>", "<C-w>x", default_opts)
keymap.set("n", "<C-h>", "<C-w>h", default_opts)
keymap.set("n", "<C-j>", "<C-w>j", default_opts)
keymap.set("n", "<C-k>", "<C-w>k", default_opts)
keymap.set("n", "<C-l>", "<C-w>l", default_opts)
keymap.set("n", "<S-Right>", "<CMD>vertical resize +5<CR>", default_opts)
keymap.set("n", "<S-Left>", "<CMD>vertical resize -5<CR>", default_opts)
keymap.set("n", "<S-Down>", "<CMD>resize -5<CR>", default_opts)
keymap.set("n", "<S-Up>", "<CMD>resize +5<CR>", default_opts)

-- Comment
keymap.set("n", "cc", "gcc", remap_opts)
keymap.set("v", "cc", "gc", remap_opts)

-- Snippet disable session
vim.keymap.set({ "i", "s" }, "<Esc>", function()
  vim.snippet.stop()
  return "<Esc>"
end, { expr = true }) -- expr 會執行一個 function 把回傳的結果當成一個 command 執行

-- Temporary disable hightlight
keymap.set("n", "<ESC>", "<CMD>noh<CR>", default_opts)

-- Use cp shortcut to copy editing file path
keymap.set("n", "cp", "<CMD>let @+=expand('%:p:h')<CR>", default_opts)

-- yank word and paste without override register
keymap.set("v", "p", "pgvy", default_opts)

-- hightlight, but don't jump
keymap.set("n", "*", "<CMD>keepjumps normal! mi*`i<CR>", default_opts)

-- Diff
keymap.set("n", "<LEADER>d", function()
  if vim.o.diff then
    vim.cmd('diffoff')
  else
    vim.cmd('diffthis')
  end
end, default_opts)
keymap.set("n", "<LEADER>D", "<CMD>diffoff!<CR>", default_opts)

-- Disable default LSP keymap
-- https://neovim.io/doc/user/lsp.html#_global-defaults
keymap.del("n", "gO")
keymap.del({ "n", "x" }, "gra")
keymap.del("n", "grr")
keymap.del("n", "gri")
keymap.del("n", "grn")
keymap.del("i", "<C-S>")

-- Cheat Sheet
-- <C-^> Switch between current and alternate buffer
-- z=    Spelling suggestions for word under cursor
-- gF    Jump to file path under cursor
-- gx    Open URL under cursor in browser
-- J     (Visual mode) Join selected lines
-- O     (Visual mode) Move cursor to other end of selection
