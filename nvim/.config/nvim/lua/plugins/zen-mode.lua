return {
  'folke/zen-mode.nvim',
  enabled = true,
  config = function()
    local zen_mode = require('zen-mode')
    zen_mode.setup({
      window = {
        backdrop = 1,
        width = 0.65,
      },
    })

    local keymap = vim.keymap.set

    keymap("n", "m", ":ZenMode<CR>")
  end
}
