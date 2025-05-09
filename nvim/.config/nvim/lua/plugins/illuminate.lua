return {
  'RRethy/vim-illuminate', -- automatically highlighting other uses of the word under the cursor
  enabled = true,
  config = function()
    local lsp_keyword_mark = require('illuminate')
    local default_opts = { noremap = true, silent = true }

    local keymap = vim.keymap.set
    keymap("n", "J", function()
      lsp_keyword_mark.goto_next_reference(false)
    end, default_opts)
    keymap("n", "K", function()
      lsp_keyword_mark.goto_prev_reference(false)
    end, default_opts)
  end,
}
