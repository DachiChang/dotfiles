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
keymap('n', '<leader>k', builtin.keymaps, {})

-- search and jump to tabs
require('telescope-tabs').setup {
  show_preview = false,
  entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
    local exclude_file_names = {
      "NvimTree",
      "Tagbar",
    }

    local is_exclude = function(filename)
      for _, exclude_file_name in ipairs(exclude_file_names) do
        if filename:find(exclude_file_name) then
          return true
        end
      end
      return false
    end

    local filter_names = {}
    for _, file_name in ipairs(file_names) do
      if not is_exclude(file_name) then
        table.insert(filter_names, file_name)
      end
    end
    return string.format('%d: %s%s', tab_id, table.concat(filter_names, ', '), is_current and ' <' or '')
  end,
}
local tabs = require('telescope-tabs')
keymap('n', '<leader>t', tabs.list_tabs, {})
keymap('n', 'tt', tabs.go_to_previous, {})
