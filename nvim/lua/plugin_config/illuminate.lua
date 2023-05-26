local lsp_keyword_mark = require('illuminate')
local default_opts = { nowait = true, noremap = true, silent = true }

local keymap = vim.keymap
keymap.set('n', ']', lsp_keyword_mark.goto_next_reference, default_opts)
keymap.set('n', '[', lsp_keyword_mark.goto_prev_reference, default_opts)

local api = vim.api
api.nvim_set_hl(0, "IlluminatedWordText", { underline = true })
api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true })
api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true })
