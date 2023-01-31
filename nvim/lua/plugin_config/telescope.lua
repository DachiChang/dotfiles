local keymap = vim.keymap.set
require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['t'] = "select_tab",
        ['v'] = "select_vertical",
        ['s'] = "select_horizontal",
      },
    }
  }
}
local builtin = require('telescope.builtin')
keymap('n', '<leader>f', builtin.find_files, {})
keymap('n', '<leader>g', builtin.live_grep, {})
keymap('n', '<leader>h', builtin.help_tags, {})
keymap('n', '<leader>b', builtin.buffers, {})
