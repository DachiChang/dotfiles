return {
  'folke/zen-mode.nvim',
  enabled = true,
  config = function()
    local zen_mode = require('zen-mode')
    zen_mode.setup {
      window = {
        width = 0.6,
      },
    }

    local keymap = vim.keymap.set

    keymap("n", "+", ":ZenMode<CR>")
  end
}
