return {
  'ntpeters/vim-better-whitespace',
  enabled = true,
  config = function()
    local g = vim.g
    local keymap = vim.keymap.set

    g.better_whitespace_filetypes_blacklist = {
      "toggleterm",
    }
    keymap("n", "tm", ":StripWhitespace<CR>")
  end,
}
