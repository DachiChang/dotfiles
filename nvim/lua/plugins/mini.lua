return {
  'echasnovski/mini.nvim',
  enabled = true,
  version = '*',
  config = function()
    local mini_comment = require('mini.comment')
    mini_comment.setup {
      options = {
        custom_commentstring = nil,
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
      },
      mappings = {
        comment = 'cc',
        comment_line = 'cc',
        comment_visual = 'cc',
        textobject = 'cc',
      },
      hooks = {
        -- Before successful commenting. Does nothing by default.
        pre = function() end,
        -- After successful commenting. Does nothing by default.
        post = function() end,
      },
    }

    local mini_indentscope = require('mini.indentscope')
    mini_indentscope.setup {
      draw = {
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
