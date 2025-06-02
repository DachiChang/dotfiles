local keymap = vim.keymap
local default_opts = { noremap = true, silent = true }
local remap_opts = { remap = true, silent = true }

-- NOTE: keymap mode short-name
-- n: normal
-- v: visual
-- x: visual line
-- i: insert
-- t: terminal
-- c: command
-- o: operator (like d, y, c, etc.)

-- Quit
keymap.set("n", "<C-q>", ":q!<CR>", default_opts)

-- Jump
keymap.set({ "n", "v" }, "<C-d>", "10j", default_opts)
keymap.set({ "n", "v" }, "<C-u>", "10k", default_opts)

-- Tab
keymap.set("n", "<", ":tabm -1<CR>", default_opts)
keymap.set("n", ">", ":tabm +1<CR>", default_opts)
keymap.set("n", "<C-n>", ":tabnext<CR>", default_opts)
keymap.set("n", "<C-p>", ":tabprev<CR>", default_opts)
keymap.set("n", "<C-t>", ":tabnew<CR>", default_opts)

-- Functional
keymap.set("n", "<F5>", ":e!<CR>", default_opts)

-- Window
keymap.set("n", "=", "<C-w>=", default_opts)
keymap.set("n", "<C-x>", "<C-w>x", default_opts)
keymap.set("n", "<C-h>", "<C-w>h", default_opts)
keymap.set("n", "<C-j>", "<C-w>j", default_opts)
keymap.set("n", "<C-k>", "<C-w>k", default_opts)
keymap.set("n", "<C-l>", "<C-w>l", default_opts)
keymap.set("n", "<S-Right>", ":vertical resize +5<CR>", default_opts)
keymap.set("n", "<S-Left>", ":vertical resize -5<CR>", default_opts)
keymap.set("n", "<S-Down>", ":resize -5<CR>", default_opts)
keymap.set("n", "<S-Up>", ":resize +5<CR>", default_opts)

-- Comment
keymap.set("n", "cc", "gcc", remap_opts)
keymap.set("v", "cc", "gc", remap_opts)

-- Temporary disable hightlight
keymap.set("n", "<ESC>", ":noh<CR>", default_opts)

-- Use cp shortcut to copy editing file path
keymap.set("n", "cp", ":let @+=expand('%:p:h')<CR>", default_opts)

-- yank word and paste without override register
keymap.set("v", "p", "pgvy", default_opts)

-- hightlight, but don't jump
keymap.set("n", "*", ":keepjumps normal! mi*`i<CR>", default_opts)

-- Diff
keymap.set("n", "<LEADER>d", function()
  if vim.o.diff then
    vim.cmd('diffoff')
  else
    vim.cmd('diffthis')
  end
end, default_opts)
keymap.set("n", "<LEADER>D", ":diffoff!<CR>", default_opts)

-- Disable default LSP keymap
-- https://neovim.io/doc/user/lsp.html#_global-defaults
keymap.del("n", "gO")
keymap.del({ "n", "x" }, "gra")
keymap.del("n", "grr")
keymap.del("n", "gri")
keymap.del("n", "grn")
keymap.del("i", "<C-S>")
