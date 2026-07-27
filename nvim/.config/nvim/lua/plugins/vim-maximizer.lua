return {
  'szw/vim-maximizer',
  enabled = true,
  init = function()
    local g = vim.g
    g.maximizer_set_default_mapping = 0

    local keymap = vim.keymap.set
    -- Toggle with bang "!" to recover window layout
    keymap("n", "m", "<CMD>MaximizerToggle!<CR>")
  end
}
