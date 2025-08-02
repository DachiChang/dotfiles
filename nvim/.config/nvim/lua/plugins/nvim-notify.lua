return {
  'rcarriga/nvim-notify',
  enabled = false, -- for debug use
  config = function()
    require("notify").setup({
      background_colour = 'FloatShadow',
      timeout = 3000,
    })
    vim.notify = require('notify')
  end
}
