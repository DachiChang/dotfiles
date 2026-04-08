return {
  'kristijanhusak/vim-dadbod-ui',
  enabled = true,
  dependencies = {
    'tpope/vim-dadbod',
    'davesavic/dadbod-ui-yank',
  },
  cmd = {
    'DBUIToggle',
  },
  init = function()
    local g = vim.g

    g.db_ui_use_nerd_fonts = 1
    g.db_ui_show_help = 0
    g.db_ui_auto_execute_table_helpers = 1
    g.db_ui_disable_mappings = 1
    g.db_ui_execute_on_save = 0
    g.db_ui_force_echo_notifications = 1
    -- custom table helpers
    g.db_ui_table_helpers = {
      postgresql = {
        Count = 'SELECT COUNT(*) FROM "{table}"',
        List = 'SELECT * FROM {optional_schema}"{table}" LIMIT 10',
      },
      sqlite = {
        List = 'SELECT * FROM "{table}" LIMIT 10',
        Count = 'SELECT COUNT(*) FROM "{table}"',
      }
    }

    local keymap = vim.keymap.set
    keymap("n", "<F1>", "<CMD>DBUIToggle<CR>")
  end,
  config = function()
    local keymap = vim.keymap.set

    -- dadbod-ui-yank setup
    local dadbod_ui_yank = require('dadbod-ui-yank')
    dadbod_ui_yank.setup({
      with_headers = true,
    })

    -- dadbod-ui setup
    local dadbod_ui_augroup = vim.api.nvim_create_augroup("DadbodUIKeymap", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbui",
      group = dadbod_ui_augroup,
      callback = function(event)
        local bufopts = { buffer = event.buf, nowait = true } -- 有一些鍵會等其它的 keymap 要設 nowait
        keymap("n", "<CR>", "<Plug>(DBUI_SelectLine)", bufopts)
        keymap("n", "d", "<Plug>(DBUI_DeleteLine)", bufopts)
        keymap("n", "r", "<Plug>(DBUI_Redraw)", bufopts)
        keymap("n", "e", "<Plug>(DBUI_RenameLine)", bufopts)
        keymap("n", "a", "<Plug>(DBUI_AddConnection)", bufopts)
        keymap("n", "<Tab>", "<Plug>(DBUI_ToggleDetails)", bufopts)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbout",
      group = dadbod_ui_augroup,
      callback = function(event)
        local bufopts = { buffer = event.buf }
        keymap("n", "<Tab>", "<Plug>(DBUI_ToggleResultLayout)", bufopts)
        keymap({ "n", "v" }, "yc", ":DBUIYankAsCSV<CR>", bufopts) -- 因為需要傳 range 進去，所以不能用 <CMD> 直接執行
        keymap({ "n", "v" }, "yj", ":DBUIYankAsJSON<CR>", bufopts)
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "sql",
      group = dadbod_ui_augroup,
      callback = function(event)
        local bufopts = { buffer = event.buf }
        keymap("v", "<CR>", "<Plug>(DBUI_ExecuteQuery)", bufopts)
        keymap("n", "s", "<Plug>(DBUI_SaveQuery)", bufopts)
      end,
    })
  end
}
