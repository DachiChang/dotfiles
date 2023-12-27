return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local lualine = require('lualine')
    lualine.setup {
      options = {
        theme = 'gruvbox_dark',
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 2, -- show full path
          }
        },
      },
    }
  end,
}
