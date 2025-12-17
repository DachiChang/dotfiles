return {
  'akinsho/toggleterm.nvim',
  enabled = true,
  config = function()
    local toggleterm = require('toggleterm')
    toggleterm.setup({
      open_mapping = "<LEADER><ESC>", -- \ + ESC to toggleTerm
      direction = "float",
      float_opts = {
        border = 'curved',
      },
    })

    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }
    -- Prepare 1 ~ 9 terminal, 0 can't be a terminal count
    for i = 1, 9 do
      -- <C-\><C-n> to exist terminal mode to normal mode
      keymap({ "n", "t" }, "<LEADER>" .. i, "<CMD>ToggleTerm" .. i .. "<CR>", default_opts)
    end
  end,
}
