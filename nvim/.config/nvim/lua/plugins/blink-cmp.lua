return {
  'saghen/blink.cmp',
  enabled = true,
  version = '1.*',
  -- build = 'cargo build --release',
  dependencies = {
    'rafamadriz/friendly-snippets', -- source snippets
  },
  config = function()
    local cmp = require('blink-cmp')
    cmp.setup {
      keymap = {
        preset = 'enter',
      },
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        menu = {
          max_height = 12,
          border = 'rounded',
          draw = {
            columns = {
              { "source_name" },
              { "label" },
              { "kind_icon",  "kind", gap = 1 }
            },
          },
        },
        documentation = {
          window = {
            border = 'rounded',
          },
          auto_show = true,
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lsp = {
            name = '[Lsp]',
            score_offset = 0,
            fallbacks = { 'buffer' },
          },
          path = {
            name = '[Path]',
            score_offset = -1,
            fallbacks = { 'buffer' },
          },
          buffer = {
            name = '[Buff]',
            score_offset = -3,
          },
          snippets = {
            name = '[Snip]',
            score_offset = -2,
          },
          cmdline = {
            name = '[Cmd]'
          }
        },
      },
      cmdline = {
        keymap = {
          preset = 'inherit' },
        completion = {
          list = {
            selection = {
              preselect = false,
              auto_insert = false,
            }
          },
          menu = {
            auto_show = true,
          },
        },
      },
      signature = {
        enabled = true,
        window = {
          border = 'rounded',
          show_documentation = true,
        },
      },
    }
  end,
}
