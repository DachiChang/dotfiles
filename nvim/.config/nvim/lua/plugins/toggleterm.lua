return {
  'akinsho/toggleterm.nvim',
  enabled = true,
  config = function()
    local toggleterm = require('toggleterm')
    toggleterm.setup({
      direction = "float",
      open_mapping = "<LEADER><ESC>",
      float_opts = {
        border = 'curved',
      },
    })

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      count = 10,
      hidden = true,
      direction = "float",
    })

    local keymap = vim.keymap.set
    -- toggle lazygit
    keymap({ "n", "t" }, "<C-\\>", function()
      lazygit:toggle()
    end)

    -- toggle 1 ~ 9 terminal
    for i = 1, 9 do
      keymap({ "n", "t" }, string.format("<leader>%d", i), string.format("<cmd>ToggleTerm%d<cr>", i))
    end
  end,
}
