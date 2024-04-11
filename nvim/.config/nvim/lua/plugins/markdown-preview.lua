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
  end,
  config = function()
    local keymap = vim.keymap.set

    keymap("n", "<F10>", "<CMD>MarkdownPreview<CR>")
  end,
}
