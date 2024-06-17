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
  end,
}
