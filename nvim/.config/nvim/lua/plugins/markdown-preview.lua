return {
  "iamcco/markdown-preview.nvim",
  enabled = true,
  ft = 'markdown',
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    local g = vim.g

    g.mkdp_theme = 'light'

    local keymap = vim.keymap.set
    keymap("n", "<F2>", ":MarkdownPreview<CR>")
  end,
}
