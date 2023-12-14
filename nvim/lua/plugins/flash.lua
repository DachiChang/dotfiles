-- Quick moving in screen solution
return {
  'folke/flash.nvim',
  enabled = true,
  config = function()
    local api = vim.api
    local flash = require('flash')
    flash.setup {}

    api.nvim_set_hl(0, "FlashLabel", { ctermbg = 161, bold = true })
  end,
}
