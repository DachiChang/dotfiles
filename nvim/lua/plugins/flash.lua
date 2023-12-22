-- Quick moving in screen solution
return {
  'folke/flash.nvim',
  enabled = true,
  config = function()
    local flash = require('flash')
    flash.setup {}
  end,
}
