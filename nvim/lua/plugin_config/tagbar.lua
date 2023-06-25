local keymap = vim.keymap.set
local opt = vim.opt

keymap("n", "<leader>8", ":TagbarToggle<CR>")
keymap("n", "g8", ":TagbarOpen fj<CR>") -- always jump to the Tagbar window, opening it first if necessary
opt.updatetime = 250
