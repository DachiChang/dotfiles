require('flash').setup {}

local api = vim.api
api.nvim_set_hl(0, "FlashLabel", { ctermbg = 161, bold = true })
