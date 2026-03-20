-- REQUIRED: brew install tree-sitter-cli
return {
  'MeanderingProgrammer/treesitter-modules.nvim',
  enabled = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    lazy = false,
    build = ":TSUpdate", -- NOTE: will be updated parsers when this plugin is updated
  },
  config = function()
    local treesitter_modules = require('treesitter-modules')
    treesitter_modules.setup({
      auto_install = true,
      fold = {
        enable = true,
      },
      highlight = {
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
      indent = {
        enable = true,
      },
    })
  end
}
