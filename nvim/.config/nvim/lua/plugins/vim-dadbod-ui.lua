return {
  'kristijanhusak/vim-dadbod-ui',
  enabled = true,
  dependencies = {
    'tpope/vim-dadbod',
  },
  cmd = {
    'DBUIToggle',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_disable_mappings = 1
    vim.g.db_ui_execute_on_save = 0
    vim.g.db_ui_force_echo_notifications = 1

    local keymap = vim.keymap.set
    keymap("n", "<F6>", ":DBUIToggle<CR>")
  end,
  config = function()
    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true, buffer = true, nowait = true }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbui",
      callback = function()
        keymap("n", "<CR>", "<Plug>(DBUI_SelectLine)", default_opts)
        keymap("n", "d", "<Plug>(DBUI_DeleteLine)", default_opts)
        keymap("n", "r", "<Plug>(DBUI_Redraw)", default_opts)
        keymap("n", "e", "<Plug>(DBUI_RenameLine)", default_opts)
        keymap("n", "a", "<Plug>(DBUI_AddConnection)", default_opts)
        keymap("n", "<Tab>", "<Plug>(DBUI_ToggleDetails)", default_opts)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbout",
      callback = function()
        keymap("n", "<Tab>", "<Plug>(DBUI_ToggleResultLayout)", default_opts)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "sql",
      callback = function()
        keymap("v", "<CR>", "<Plug>(DBUI_ExecuteQuery)", default_opts)
        keymap("n", "s", "<Plug>(DBUI_SaveQuery)", default_opts)
      end,
    })
  end
}
