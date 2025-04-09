return {
  'rcarriga/nvim-notify',
  enabled = false, -- for debug use
  config = function()
    require("notify").setup()
    vim.notify = require('notify')
  end
}
