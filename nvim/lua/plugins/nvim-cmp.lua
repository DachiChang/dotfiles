return {
  'hrsh7th/nvim-cmp', -- completion
  enabled = true,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',         -- bridge lspconfig
    'hrsh7th/cmp-buffer',           -- source from buffer
    'hrsh7th/cmp-path',             -- source from path
    'hrsh7th/cmp-cmdline',          -- source from cmd line
    'L3MON4D3/LuaSnip',             -- snippet engine
    'saadparwaiz1/cmp_luasnip',     -- bridge LuaSnip
    'dmitmel/cmp-cmdline-history',  -- source cmdline history
    'rafamadriz/friendly-snippets', -- source snippets
  },
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load() -- load friendly-snippets

    local cmp = require('cmp')
    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,CursorLine:CmpPmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = { 'menu', 'abbr', 'kind' }, -- '[Cmd]  hit-enter  Variable'
        format = function(entry, item)
          local menu = {
            nvim_lsp = '[Lsp]',
            luasnip = '[Snip]',
            buffer = '[Buff]',
            path = '[Path]',
            cmdline = '[Cmd]',
            cmdline_history = '[History]',
          }
          item.menu = menu[entry.source.name]
          return item
        end,
      },
      preselect = cmp.PreselectMode.None,
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<ESC>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })

    -- Use buffer source for `/` and `?`
    -- cmp.setup.cmdline({ '/', '?' }, {
    --   mapping = cmp.mapping.preset.cmdline({
    --     ['<Down>'] = {
    --       c = function(fallback)
    --         if cmp.visible() then
    --           cmp.select_next_item()
    --         else
    --           fallback()
    --         end
    --       end,
    --     },
    --     ['<Up>'] = {
    --       c = function(fallback)
    --         if cmp.visible() then
    --           cmp.select_prev_item()
    --         else
    --           fallback()
    --         end
    --       end,
    --     },
    --   }),
    --   sources = {
    --     { name = 'buffer' }
    --   }
    -- })

    -- Use cmdline & path source for ':'
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline({
        ['<Down>'] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
        },
        ['<Up>'] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end,
        },
      }),
      sources = cmp.config.sources({
        { name = 'path' },    -- priority first
      }, {
        { name = 'cmdline' }, -- if not path can complete, use cmdline instead of
      })
    })

    -- cmp menu color
    local api = vim.api
    api.nvim_set_hl(0, "CmpPmenu", { ctermbg = 234 })
    api.nvim_set_hl(0, "CmpPmenuSel", { ctermbg = 238 })
    api.nvim_set_hl(0, "CmpItemMenu", { ctermfg = 243 })
    api.nvim_set_hl(0, "CmpItemAbbrMatch", { ctermfg = 81 })
    api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { ctermfg = 81 })
    api.nvim_set_hl(0, "CmpItemKindMethod", { ctermfg = 118 })
    api.nvim_set_hl(0, "CmpItemKindFunction", { ctermfg = 118 })
    api.nvim_set_hl(0, "CmpItemKindVariable", { ctermfg = 161 })
    api.nvim_set_hl(0, "CmpItemKindClass", { ctermfg = 81 })
    api.nvim_set_hl(0, "CmpItemKindModule", { ctermfg = 214 })
    api.nvim_set_hl(0, "CmpItemKindConstant", { ctermfg = 135 })
  end,
}
