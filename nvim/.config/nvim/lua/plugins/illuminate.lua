return {
  'RRethy/vim-illuminate',
  enabled = true,
  event = "VeryLazy",
  config = function()
    local lsp_keyword_mark = require('illuminate')
    local default_opts = { nowait = true, noremap = true, silent = true }

    local keymap = vim.keymap.set
    keymap("n", "]", function()
      lsp_keyword_mark.goto_next_reference(false)
    end, default_opts)
    keymap("n", "[", function()
      lsp_keyword_mark.goto_prev_reference(false)
    end, default_opts)
  end,
}
