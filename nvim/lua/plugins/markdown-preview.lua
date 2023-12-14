return {
  "iamcco/markdown-preview.nvim",
  enabled = true,
  ft = 'markdown',
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    local g = vim.g
    g.mkdp_theme = 'light'

    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }
    keymap("n", "<F10>", ":MarkdownPreviewToggle<CR>", default_opts)
  end,
}
