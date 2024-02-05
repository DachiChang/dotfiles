return {
  'norcalli/nvim-colorizer.lua',
  enabled = true,
  config = function()
    local colorizer = require('colorizer')
    colorizer.setup()
  end
}
