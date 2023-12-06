return {
  'ntpeters/vim-better-whitespace',
  enabled = true,
  config = function()
    local g = vim.g
    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }

    g.better_whitespace_filetypes_blacklist = {
      "toggleterm",
    }
    keymap("n", "tm", ":StripWhitespace<CR>", default_opts)
  end,
}
