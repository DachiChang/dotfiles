return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  build = ":TSUpdate", -- NOTE: will be updated parsers when this plugin is updated
  config = function()
    local treesitter_config = require('nvim-treesitter.configs')
    treesitter_config.setup {
      auto_install = true, -- auto install the missing parse when enter the buffer
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<Space>',
          node_incremental = '<Space>',
          scope_incremental = false,
          node_decremental = '<BS>',
        },
      },
    }

    -- use treesitter to provider fold functional
    local opt = vim.opt
    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"
    -- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    opt.foldtext = ""
    opt.foldenable = true
    opt.foldlevelstart = 99
  end
}
