local g = vim.g
local keymap = vim.keymap.set

g.autopep8_max_line_length = 140
g.autopep8_disable_show_diff = 1

keymap("n", "gf", ":Autopep8<CR>") -- go format
