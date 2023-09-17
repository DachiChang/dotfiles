require('flash').setup {
  modes = {
    search = {
      highlight = {
        backdrop = true,
      },
    },
    char = {
      enabled = true,
    },
  },
}

local api = vim.api
api.nvim_set_hl(0, "FlashLabel", { ctermbg = 162 })
