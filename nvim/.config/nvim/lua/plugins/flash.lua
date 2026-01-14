-- Quick moving in screen solution
return {
  'folke/flash.nvim',
  enabled = true,
  config = function()
    local flash = require('flash')
    flash.setup({
      highlight = {
        backdrop = false,
      },
      label = {
        rainbow = {
          enabled = true,
        },
      },
    })

    local keymap = vim.keymap.set

    keymap("n", "|", flash.jump)
  end,
}
