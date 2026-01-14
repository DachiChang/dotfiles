local keymap = vim.keymap

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
keymap.set("n", "<C-q>", "<CMD>q!<CR>")
keymap.set("n", "<LEADER>q", "<CMD>qa!<CR>")

-- Jump
keymap.set("n", "<LEADER>\\", "<CMD>e#<CR>")

-- Tab
keymap.set("n", "<", "<CMD>tabm -1<CR>")
keymap.set("n", ">", "<CMD>tabm +1<CR>")
keymap.set("n", "<C-n>", "<CMD>tabnext<CR>")
keymap.set("n", "<C-p>", "<CMD>tabprev<CR>")
keymap.set("n", "<C-t>", "<CMD>tabnew<CR>")

-- Functional
keymap.set("n", "<F5>", "<CMD>e!<CR>")

-- Window
keymap.set("n", "=", "<C-w>=")
keymap.set("n", "<C-x>", "<C-w>x")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<S-Right>", "<CMD>vertical resize +5<CR>")
keymap.set("n", "<S-Left>", "<CMD>vertical resize -5<CR>")
keymap.set("n", "<S-Down>", "<CMD>resize -5<CR>")
keymap.set("n", "<S-Up>", "<CMD>resize +5<CR>")

-- Comment
keymap.set("n", "cc", "gcc", { remap = true })
keymap.set("v", "cc", "gc", { remap = true })

-- Snippet disable session
vim.keymap.set({ "i", "s" }, "<Esc>", function()
  vim.snippet.stop()
  return "<Esc>"
end, { expr = true }) -- expr 會執行一個 function 把回傳的結果當成一個 command 執行

-- Temporary disable hightlight
keymap.set("n", "<ESC>", "<CMD>noh<CR>")

-- Use cp shortcut to copy editing file path
keymap.set("n", "cp", "<CMD>let @+=expand('%:p:h')<CR>")

-- yank word and paste without override register
keymap.set("v", "p", "pgvy")

-- hightlight, but don't jump
keymap.set("n", "*", "<CMD>keepjumps normal! mi*`i<CR>")

-- Diff
keymap.set("n", "<LEADER>d", function()
  if vim.o.diff then
    vim.cmd('diffoff')
  else
    vim.cmd('diffthis')
  end
end)
keymap.set("n", "<LEADER>D", "<CMD>diffoff!<CR>")

-- Disable default LSP keymap
-- https://neovim.io/doc/user/lsp.html#_global-defaults
keymap.del({ "n", "x" }, "gra")
keymap.del("n", "gri")
keymap.del("n", "grn")
keymap.del("n", "grr")
keymap.del("n", "gO")
keymap.del("i", "<C-S>")

-- Cheat Sheet
-- <C-^> Switch between current and alternate buffer
-- z=    Spelling suggestions for word under cursor
-- gF    Jump to file path under cursor
-- gx    Open URL under cursor in browser
-- J     (Visual mode) Join selected lines
-- O     (Visual mode) Move cursor to other end of selection
