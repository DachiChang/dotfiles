return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local function total_lines()
      return 'Total:' .. vim.api.nvim_buf_line_count(0)
    end
    local lualine = require('lualine')
    lualine.setup({
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
        lualine_z = {
          { total_lines },
        }
      },
    })
  end,
}
