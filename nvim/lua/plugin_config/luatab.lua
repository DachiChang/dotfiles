require('luatab').setup {
  filterFileType = {
    "help",
    "lazy",
    "mason",
    "spectre_panel",
    "toggleterm",
    "TelescopePrompt",
    "TelescopeResults",
    "NvimTree",
    "tagbar",
  },
}

-- tabline
local api = vim.api
-- api.nvim_set_hl(0, "TabLineFill", { ctermfg = 255, ctermbg = 236 })
-- api.nvim_set_hl(0, "TabLine", { ctermfg = 255, ctermbg = 236 })
-- api.nvim_set_hl(0, "TabLineSel", { bold = true, ctermfg = 255, ctermbg = 239 })
-- api.nvim_set_hl(0, "TabLineFill", { ctermfg = 255, ctermbg = 52 })
-- api.nvim_set_hl(0, "TabLine", { ctermfg = 255, ctermbg = 52 })
-- api.nvim_set_hl(0, "TabLineSel", { ctermfg = 255, ctermbg = 124 })
api.nvim_set_hl(0, "TabLineFill", { ctermfg = 255, ctermbg = 54 })
api.nvim_set_hl(0, "TabLine", { ctermfg = 255, ctermbg = 54 })
api.nvim_set_hl(0, "TabLineSel", { ctermfg = 255, ctermbg = 91 })
