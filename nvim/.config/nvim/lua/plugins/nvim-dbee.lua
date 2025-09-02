return {
  "kndndrj/nvim-dbee",
  enabled = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  config = function()
    local dbee = require('dbee')
    dbee.setup({
      drawer = {
        window_options = {
          foldmethod = "manual",
        },

        disable_help = true,

        mappings = {
          { key = "r",     mode = "n", action = "refresh" },
          { key = "<CR>",  mode = "n", action = "action_1" },
          { key = "e",     mode = "n", action = "action_2" },
          { key = "d",     mode = "n", action = "action_3" },
          { key = "o",     mode = "n", action = "toggle" },
          { key = "<CR>",  mode = "n", action = "menu_confirm" },
          { key = "y",     mode = "n", action = "menu_yank" },
          { key = "<Esc>", mode = "n", action = "menu_close" },
        },
      },

      result = {
        window_options = {
          foldmethod = "manual",
        },

        page_size = 100,
        focus_result = false,

        mappings = {
          { key = "f",     mode = "",  action = "page_first" },
          { key = "n",     mode = "",  action = "page_next" },
          { key = "p",     mode = "",  action = "page_prev" },
          { key = "e",     mode = "",  action = "page_last" },
          { key = "yj",    mode = "n", action = "yank_current_json" },
          { key = "yj",    mode = "v", action = "yank_selection_json" },
          { key = "yJ",    mode = "",  action = "yank_all_json" },
          { key = "yc",    mode = "n", action = "yank_current_csv" },
          { key = "yc",    mode = "v", action = "yank_selection_csv" },
          { key = "yC",    mode = "",  action = "yank_all_csv" },
          { key = "<C-c>", mode = "",  action = "cancel_call" },
        },
      },

      editor = {
        mappings = {
          { key = "BB",   mode = "v", action = "run_selection" },
          { key = "BB",   mode = "n", action = "run_file" },
          { key = "<CR>", mode = "n", action = "run_under_cursor" },
        },
      },

      -- call log window config
      call_log = {
        -- see drawer comment.
        window_options = {
          foldmethod = "manual",
        },

        -- mappings for the buffer
        mappings = {
          { key = "<CR>",  mode = "", action = "show_result" },
          { key = "<C-c>", mode = "", action = "cancel_call" },
        },
      },

      -- window layout
      window_layout = require("dbee.layouts").Default:new(),
    })

    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }
    keymap("n", "<F10>", dbee.toggle, default_opts)
  end,
}
