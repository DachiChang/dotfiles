-- DISABLE: switch to luatab
return {
  'akinsho/bufferline.nvim',
  enabled = false,
  version = "*",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup {
      options = {
        mode = 'tabs',
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = { '', '' },
        indicator = {
          style = 'none',
        },
        show_duplicate_prefix = false,
        always_show_bufferline = false,
      },
      highlights = {
        fill = {
          ctermfg = 255,
          ctermbg = 236,
        },
        background = {
          ctermfg = 255,
          ctermbg = 236,
        },
        buffer_selected = {
          ctermfg = 255,
          ctermbg = 239,
        },
        indicator_selected = {
          ctermfg = 198,
          ctermbg = 239,
        },
        modified_selected = {
          ctermfg = 196,
          ctermbg = 239,
        },
        modified = {
          ctermfg = 88,
          ctermbg = 236,
        },
      },
    }
  end,
}
