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
keymap('n', '<leader>s', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', default_opts)
keymap('v', '<leader>s', '<esc><cmd>lua require("spectre").open_visual()<CR>', default_opts)
