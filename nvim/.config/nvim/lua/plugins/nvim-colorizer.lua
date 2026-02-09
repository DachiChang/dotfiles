return {
  'catgoose/nvim-colorizer.lua',
  enabled = true,
  config = function()
    local colorizer = require('colorizer')
    colorizer.setup({
      user_default_options = {
        names = false, -- disable Name color ex: Red, Blue
        tailwind = true,
      }
    })
  end
}
