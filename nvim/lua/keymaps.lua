local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Quit
keymap("n", "<C-q>", ":q!<CR>", default_opts)

-- Jump
keymap("n", "gm", "'M", default_opts)
keymap("n", "m", "mM", default_opts)

-- Fold
keymap("n", "<Space>", "za", default_opts)

-- Tab
keymap("n", "<", ":tabm -1<CR>", default_opts)
keymap("n", ">", ":tabm +1<CR>", default_opts)
keymap("n", "<C-n>", ":tabnext<CR>", default_opts)
keymap("n", "<C-p>", ":tabprev<CR>", default_opts)
keymap("n", "<C-t>", ":tabnew<CR>", default_opts)

-- Functional
keymap("n", "<F5>", ":e!<CR>", default_opts)

-- Panes
keymap("n", "=", "<C-w>=", default_opts)
keymap("n", "-", "<C-w>x", default_opts)
keymap("n", "<C-h>", "<C-w>h", default_opts)
keymap("n", "<C-j>", "<C-w>j", default_opts)
keymap("n", "<C-k>", "<C-w>k", default_opts)
keymap("n", "<C-l>", "<C-w>l", default_opts)
keymap("n", "<S-Right>", ":vertical resize +3<CR>", default_opts)
keymap("n", "<S-Left>", ":vertical resize -3<CR>", default_opts)
keymap("n", "<S-Down>", ":resize -3<CR>", default_opts)
keymap("n", "<S-Up>", ":resize +3<CR>", default_opts)

-- Search for visually selected text
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], default_opts)
-- Temporary disable hightlight
keymap("n", "<ESC>", ":noh<CR>", default_opts)
-- Use cp shortcut to copy editing file path
keymap("n", "cp", ":let @+=expand('%:p:h')<CR>", default_opts)

-- yank word and paste without override register
keymap("x", "p", "pgvy", default_opts)

-- ESC to exist terminal mode to normal mode
keymap("t", "<C-q>", [[<C-\><C-n>]], default_opts)
