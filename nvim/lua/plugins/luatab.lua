return {
  'dachichang/luatab.nvim',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local luatab = require('luatab')
    local api = vim.api

    luatab.setup {
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
    -- api.nvim_set_hl(0, "TabLineFill", { ctermfg = 255, ctermbg = 236 })
    -- api.nvim_set_hl(0, "TabLine", { ctermfg = 255, ctermbg = 236 })
    -- api.nvim_set_hl(0, "TabLineSel", { bold = true, ctermfg = 255, ctermbg = 239 })
    -- api.nvim_set_hl(0, "TabLineFill", { ctermfg = 255, ctermbg = 52 })
    -- api.nvim_set_hl(0, "TabLine", { ctermfg = 255, ctermbg = 52 })
    -- api.nvim_set_hl(0, "TabLineSel", { ctermfg = 255, ctermbg = 124 })
    api.nvim_set_hl(0, "TabLineFill", { ctermfg = 255, ctermbg = 54 })
    api.nvim_set_hl(0, "TabLine", { ctermfg = 255, ctermbg = 54 })
    api.nvim_set_hl(0, "TabLineSel", { ctermfg = 255, ctermbg = 91 })
  end,
}
