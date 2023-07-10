local keymap = vim.keymap.set
local opt = vim.opt

keymap("n", "gs", ":TagbarOpen fj<CR>") -- always jump to the Tagbar window, opening it first if necessary
opt.updatetime = 250
