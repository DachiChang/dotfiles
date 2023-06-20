require('leap').add_default_mappings()
require('leap').opts.safe_labels = {}

-- enable global search
local keymap = vim.keymap
keymap.set({ 'n', 'v' }, '<leader>\\', function()
  local focusable_windows_on_tabpage = vim.tbl_filter(
    function(win) return vim.api.nvim_win_get_config(win).focusable end,
    vim.api.nvim_tabpage_list_wins(0)
  )
  require('leap').leap { target_windows = focusable_windows_on_tabpage }
end)
keymap.del('v', 'x')
keymap.del('v', 'X')
keymap.del('n', 's')
keymap.del('n', 'S')
keymap.del({ 'n', 'v' }, 'gs')

-- highlight group
local api = vim.api
api.nvim_set_hl(0, "LeapLabelPrimary", { ctermfg = 253, ctermbg = 162 })
api.nvim_set_hl(0, "LeapLabelSecondary", { ctermfg = 253, ctermbg = 81 })
api.nvim_set_hl(0, "LeapBackdrop", { link = 'Comment' })
