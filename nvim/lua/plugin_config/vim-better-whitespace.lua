local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }

keymap("n", "tm", ":StripWhitespace<CR>", default_opts)
