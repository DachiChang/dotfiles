return {
  'akinsho/toggleterm.nvim', -- ctrl + \ (trigger)
  enabled = true,
  config = function()
    local toggleterm = require('toggleterm')
    toggleterm.setup({
      direction = "float",
      float_opts = {
        border = 'curved',
      },
    })

    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }
    -- ESC to exist terminal mode to normal mode
    keymap("t", "<LEADER><ESC>", "<C-\\><C-n>", default_opts)
    -- Prepare 1 ~ 9 terminal, 0 can't be a terminal count
    for i = 1, 9 do
      keymap({"n", "t"}, "<LEADER>" .. i, "<CMD>ToggleTerm" .. i .. "<CR>")
    end
  end,
}
