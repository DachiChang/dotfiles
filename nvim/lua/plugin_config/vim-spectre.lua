require('spectre').setup {
  mapping = {
    ['run_current_replace'] = {
      map = "<leader>r", -- default is <leader>rc
      cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
      desc = "replace current line"
    },
  },
}

local default_opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap('n', '<F6>', '<cmd>lua require("spectre").open()<CR>', default_opts)
keymap('n', '<leader>r', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', default_opts)
keymap('v', '<leader>r', '<esc><cmd>lua require("spectre").open_visual()<CR>', default_opts)

local api = vim.api
api.nvim_set_hl(0, "SpectreHeader", { ctermfg = 220 })
api.nvim_set_hl(0, "SpectreFile", { ctermfg = 197 })
api.nvim_set_hl(0, "SpectreDir", { ctermfg = 81 })
api.nvim_set_hl(0, "SpectreBorder", { ctermfg = 240 })
api.nvim_set_hl(0, "SpectreSearch", { ctermfg = 253, ctermbg = 108 })
api.nvim_set_hl(0, "SpectreReplace", { ctermfg = 253, ctermbg = 203 })
