local keymap = vim.keymap.set
local opt = vim.opt

keymap("n", "gs", ":TagbarToggle<CR>")
opt.updatetime = 1000
