vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
require('luasnip.loaders.from_vscode').lazy_load() -- load friendly-snippets

-- cmp menu color
vim.api.nvim_set_hl(0, "CmpPmenu", { ctermbg = 234 })
vim.api.nvim_set_hl(0, "CmpPmenuSel", { ctermbg = 238 })
vim.api.nvim_set_hl(0, "CmpItemMenu", { ctermfg = 243 })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { ctermfg = 81 })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { ctermfg = 81 })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { ctermfg = 118 })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { ctermfg = 118 })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { ctermfg = 161 })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { ctermfg = 81 })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { ctermfg = 214 })
vim.api.nvim_set_hl(0, "CmpItemKindConstant", { ctermfg = 135 })

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
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<ESC>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
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
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
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
    { name = 'cmdline_history' },
    { name = 'cmdline' },
    { name = 'path' },
  })
})
