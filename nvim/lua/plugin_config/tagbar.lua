local keymap = vim.keymap.set
local opt = vim.opt

keymap("n", "<leader>8", ":TagbarToggle<CR>")
opt.updatetime = 250
