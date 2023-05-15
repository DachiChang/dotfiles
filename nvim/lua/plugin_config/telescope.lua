local keymap = vim.keymap.set
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['t'] = actions.select_tab_drop,
        ['v'] = actions.select_vertical,
        ['s'] = actions.select_horizontal,
      },
      i = {
        ['<C-t>'] = actions.select_tab_drop,
        ['<C-v>'] = actions.select_vertical,
        ['<C-s>'] = actions.select_horizontal,
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
require('telescope-tabs').setup {
  show_preview = false,
}
local tabs = require('telescope-tabs')
keymap('n', '<leader>t', tabs.list_tabs, {})
keymap('n', 'tt', tabs.go_to_previous, {})
