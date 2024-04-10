return {
  'szw/vim-maximizer',
  enabled = true,
  config = function()
    local default_opts = { noremap = true, silent = true }
    local keymap = vim.keymap.set
    keymap("n", "+", ":MaximizerToggle<CR>", default_opts)
  end
}
