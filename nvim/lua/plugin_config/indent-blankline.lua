require("indent_blankline").setup {
  enabled = false,
}

local keymap = vim.keymap
local default_opts = { noremap = true, silent = true }
keymap.set('n', '<F4>', ":IndentBlanklineToggle<CR>", default_opts)
