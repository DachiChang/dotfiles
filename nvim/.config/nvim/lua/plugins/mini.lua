return {
  'echasnovski/mini.nvim',
  enabled = true,
  version = '*',
  config = function()
    local mini_indentscope = require('mini.indentscope')
    mini_indentscope.setup {
      draw = {
        animation = mini_indentscope.gen_animation.none(),
        delay = 100,
        priority = 2,
      },
      mappings = {
        object_scope = 'ii',
        object_scope_with_border = 'ai',
        goto_top = '{',
        goto_bottom = '}',
      },
      options = {
        border = 'both',
        indent_at_cursor = true,
        try_as_border = true,
      },
      symbol = '╎',
    }

    -- disable indentscope for certain filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lazy",
        "mason",
        "toggleterm",
        "NvimTree",
        "tagbar",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
