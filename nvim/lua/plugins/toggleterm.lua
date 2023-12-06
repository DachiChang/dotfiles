return {
  'akinsho/toggleterm.nvim', -- ctrl + \ (trigger)
  enabled = true,
  config = function()
    local toggleterm = require('toggleterm')
    toggleterm.setup {
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = 'curved',
      },
    }

    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }
    -- ESC to exist terminal mode to normal mode
    vim.keymap.set("t", "<leader><ESC>", [[<C-\><C-n>]], default_opts)
  end,
}
