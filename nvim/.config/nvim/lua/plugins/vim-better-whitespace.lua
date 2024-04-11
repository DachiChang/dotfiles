return {
  'ntpeters/vim-better-whitespace',
  enabled = true,
  init = function()
    local g = vim.g

    g.better_whitespace_operator = ''
    g.better_whitespace_filetypes_blacklist = {
      "toggleterm",
    }
  end,
  config = function()
    local keymap = vim.keymap.set

    keymap("n", "tm", ":StripWhitespace<CR>")
  end,
}
