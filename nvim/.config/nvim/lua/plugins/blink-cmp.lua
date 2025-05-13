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
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' }, -- support enter
      },
      completion = {                         -- main completion
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        menu = { -- completion menu layout
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
      sources = { -- completion sources
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
      cmdline = { -- command line completion
        keymap = {
          preset = 'default' -- C-y to select and accept, <CR> to fire command
        },
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
      signature = { -- signature help, trigger by "( or ."
        enabled = true,
        window = {
          border = 'rounded',
          show_documentation = true,
        },
      },
    }
  end,
}
