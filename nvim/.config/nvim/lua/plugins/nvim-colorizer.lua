return {
  'catgoose/nvim-colorizer.lua',
  enabled = true,
  config = function()
    local colorizer = require('colorizer')
    colorizer.setup({
      user_default_options = {
        tailwind = true,
      }
    })
  end
}
