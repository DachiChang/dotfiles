require('luatab').setup()

-- tabline
local api = vim.api
api.nvim_set_hl(0, "TabLineFill", { ctermfg = 255, ctermbg = 236 })
api.nvim_set_hl(0, "TabLine", { ctermfg = 255, ctermbg = 236 })
api.nvim_set_hl(0, "TabLineSel", { bold = true, ctermfg = 255, ctermbg = 239 })
