return {
  'nvim-pack/nvim-spectre',
  enabled = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local spectre = require('spectre')
    spectre.setup {
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
    keymap('n', '<F6>', '<cmd>lua require("spectre").toggle()<CR>', default_opts)
    keymap('n', '<leader>r', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', default_opts)
    keymap('v', '<leader>r', '<esc><cmd>lua require("spectre").open_visual()<CR>', default_opts)

    -- color
    local api = vim.api
    api.nvim_set_hl(0, "SpectreHeader", { ctermfg = 220 })
    api.nvim_set_hl(0, "SpectreFile", { ctermfg = 197 })
    api.nvim_set_hl(0, "SpectreDir", { ctermfg = 81 })
    api.nvim_set_hl(0, "SpectreBorder", { ctermfg = 240 })
    api.nvim_set_hl(0, "SpectreSearch", { ctermfg = 253, ctermbg = 106 })
    api.nvim_set_hl(0, "SpectreReplace", { ctermfg = 253, ctermbg = 161 })
  end,
}
