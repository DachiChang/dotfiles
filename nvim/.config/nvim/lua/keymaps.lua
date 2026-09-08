local keymap = vim.keymap

--[[
 NOTE:
  # keymap mode short-name
    - n: normal
    - v: visual
    - s: select
    - x: visual line
    - i: insert
    - t: terminal
    - c: command
    - o: operator (like d, y, c, etc.)
]]

-- Quit
keymap.set("n", "<C-q>", ":q!<CR>")
keymap.set("n", "<LEADER>q", ":qa!<CR>")

-- Jump
keymap.set("n", "<LEADER><Tab>", ":e#<CR>")

-- Tab
keymap.set("n", "<", ":tabm -1<CR>")
keymap.set("n", ">", ":tabm +1<CR>")
keymap.set("n", "<C-n>", ":tabnext<CR>")
keymap.set("n", "<C-p>", ":tabprev<CR>")
keymap.set("n", "<C-t>", ":tabnew<CR>")

-- Functional
keymap.set("n", "<F5>", ":e!<CR>")

-- Window
keymap.set("n", "=", "<C-w>=")
keymap.set("n", "<C-x>", "<C-w>x")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<S-Right>", ":vertical resize +5<CR>")
keymap.set("n", "<S-Left>", ":vertical resize -5<CR>")
keymap.set("n", "<S-Down>", ":resize -5<CR>")
keymap.set("n", "<S-Up>", ":resize +5<CR>")

-- Incremental Selection
keymap.set("n", "<Space>", "van", { remap = true })
keymap.set("x", "<Space>", "an", { remap = true })
keymap.set("x", "<BS>", "in", { remap = true })

-- Comment
keymap.set("n", "cc", "gcc", { remap = true })
keymap.set("x", "cc", "gc", { remap = true })

-- Temporary disable hightlight
keymap.set("n", "<ESC>", ":noh<CR>")

-- Use cp shortcut to copy editing file path
keymap.set("n", "cp", ":let @+=expand('%:p:h')<CR>")

-- yank word and paste without override register
keymap.set("x", "p", "pgvy")

-- hightlight, but don't jump
keymap.set("n", "*", ":keepjumps normal! mi*`i<CR>")

-- Diff
keymap.set("n", "<LEADER>d", function()
  if vim.o.diff then
    vim.cmd('diffoff')
  else
    vim.cmd('diffthis')
  end
end)
keymap.set("n", "<LEADER>D", ":diffoff!<CR>")

-- Diagnostics
local diagnostic = vim.diagnostic
keymap.set("n", "ge", function()
  diagnostic.open_float()
end)
keymap.set("n", "ep", function()
  diagnostic.jump({ count = -1 })
end)
keymap.set("n", "en", function()
  diagnostic.jump({ count = 1 })
end)

-- Disable default LSP keymap
-- Intentionally fail if any default LSP keymap no longer exists.
-- This keeps the list aligned with Neovim's documented global defaults.
-- https://neovim.io/doc/user/lsp.html#_global-defaults
keymap.del({ "n", "x" }, "gra")
keymap.del("n", "gri")
keymap.del("n", "grn")
keymap.del("n", "grr")
keymap.del("n", "grt")
keymap.del("n", "grx")
keymap.del("n", "gO")
keymap.del("i", "<C-S>")

--[[
 NOTE:
  # Cheat Sheet
    - <C-^> Switch between current and alternate buffer
    - z=    Spelling suggestions for word under cursor
    - gF    Jump to file path under cursor
    - gx    Open URL under cursor in browser
    - J     (Visual mode) Join selected lines
    - O     (Visual mode) Move cursor to other end of selection
]]
