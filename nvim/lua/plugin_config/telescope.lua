local keymap = vim.keymap.set
require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['t'] = "select_tab",
        ['v'] = "select_vertical",
        ['s'] = "select_horizontal",
      },
      i = {
        ['C-t'] = "select_tab",
        ['C-v'] = "select_vertical",
        ['C-s'] = "select_horizontal",
      },
    }
  }
}
local builtin = require('telescope.builtin')
keymap('n', '<leader>f', function()
  builtin.find_files({ hidden = true })
end, {})
keymap('n', '<leader>g', builtin.live_grep, {})
keymap('n', '<leader>h', builtin.help_tags, {})
keymap('n', '<leader>b', builtin.buffers, {})

-- search and jump to tabs
require('telescope-tabs').setup()
local tabs = require('telescope-tabs')
keymap('n', '<leader>t', tabs.list_tabs, {})
keymap('n', 'tt', tabs.go_to_previous, {})
