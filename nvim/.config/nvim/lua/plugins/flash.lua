-- Quick moving in screen solution
return {
  'folke/flash.nvim',
  enabled = true,
  config = function()
    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }
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
      modes = {
        search = {
          enabled = true,
        },
      },
    }
  end,
}
