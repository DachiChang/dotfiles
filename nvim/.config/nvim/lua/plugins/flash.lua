-- Quick moving in screen solution
return {
  'folke/flash.nvim',
  enabled = true,
  config = function()
    local flash = require('flash')
    flash.setup {
      highlight = {
        backdrop = false,
      },
      label = {
        rainbow = {
          enabled = true,
        },
      },
    }

    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }

    keymap("n", "s", flash.jump, default_opts)
  end,
}
