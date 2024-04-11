local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Quit
keymap("n", "<C-q>", "<CMD>q!<CR>", default_opts)

-- Jump
keymap("n", "gm", "'M", default_opts)
keymap("n", "m", "mM", default_opts)
keymap({ "n", "v" }, "<C-d>", "10j", default_opts)
keymap({ "n", "v" }, "<C-u>", "10k", default_opts)

-- Tab
keymap("n", "<", "<CMD>tabm -1<CR>", default_opts)
keymap("n", ">", "<CMD>tabm +1<CR>", default_opts)
keymap("n", "<C-n>", "<CMD>tabnext<CR>", default_opts)
keymap("n", "<C-p>", "<CMD>tabprev<CR>", default_opts)
keymap("n", "<C-t>", "<CMD>tabnew<CR>", default_opts)

-- Functional
keymap("n", "<F5>", "<CMD>e!<CR>", default_opts)

-- Panes
keymap("n", "=", "<C-w>=", default_opts)
keymap("n", "-", "<C-w>x", default_opts)
keymap("n", "<C-h>", "<C-w>h", default_opts)
keymap("n", "<C-j>", "<C-w>j", default_opts)
keymap("n", "<C-k>", "<C-w>k", default_opts)
keymap("n", "<C-l>", "<C-w>l", default_opts)
keymap("n", "<S-Right>", "<CMD>vertical resize +3<CR>", default_opts)
keymap("n", "<S-Left>", "<CMD>vertical resize -3<CR>", default_opts)
keymap("n", "<S-Down>", "<CMD>resize -3<CR>", default_opts)
keymap("n", "<S-Up>", "<CMD>resize +3<CR>", default_opts)

-- Temporary disable hightlight
keymap("n", "<ESC>", "<CMD>noh<CR>", default_opts)
-- Use cp shortcut to copy editing file path
keymap("n", "cp", "<CMD>let @+=expand('%:p:h')<CR>", default_opts)
-- yank word and paste without override register
keymap("x", "p", "pgvy", default_opts)
-- hightlight, but don't jump
keymap("n", "*", "<CMD>keepjumps normal! mi*`izz<CR>", default_opts)

-- Diff
function ToggleDiff()
  if vim.o.diff then
    vim.cmd('diffoff')
  else
    vim.cmd('diffthis')
  end
end

keymap("n", "<LEADER>d", "<CMD>lua ToggleDiff()<CR>", default_opts)
keymap("n", "<LEADER>D", "<CMD>diffoff!<CR>", default_opts)
