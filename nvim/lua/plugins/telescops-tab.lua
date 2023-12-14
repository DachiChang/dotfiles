return {
  'LukasPietzschmann/telescope-tabs',
  enabled = true,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local keymap = vim.keymap.set
    local telescope_tab = require('telescope-tabs')
    telescope_tab.setup {
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
    keymap('n', '<leader>t', telescope_tab.list_tabs, {})
    keymap('n', 'tt', telescope_tab.go_to_previous, {})
  end,
}
