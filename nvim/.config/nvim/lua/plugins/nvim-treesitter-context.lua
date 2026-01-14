return {
  'nvim-treesitter/nvim-treesitter-context',
  enabled = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local treesitter_context = require('treesitter-context')
    treesitter_context.setup()

    local keymap = vim.keymap.set
    keymap("n", "g[", function()
      treesitter_context.go_to_context(vim.v.count1)
    end)
  end
}
