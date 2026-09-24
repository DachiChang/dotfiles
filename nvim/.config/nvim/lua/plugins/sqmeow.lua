return {
  "2giosangmitom/sqmeow.nvim",
  enabled = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  version = "*",
  build = function()
    -- Downloads the matching release binary; pass 'curl', 'wget', 'powershell' or 'cargo' to choose.
    require("sqmeow").install("curl")
  end,
  config = function()
    local keymap = vim.keymap.set

    local sqmeow = require('sqmeow')
    sqmeow.setup({
      ui = {
        result = {
          page_size = 100,
        },
      },
      query = {
        max_rows= 1000,
        persist_history = false,
      },
      keymaps = {
        drawer = {
          toggle = "<CR>",
          add = "a",
          new_scratchpad = "n",
          preview = "v",
          structure = "i",
        },
        result = {
          detail = "<CR>",
          structure = "i",
          filter = "f",
          order = false,
          reset_view = "r",
          hide_column = "-",
          show_columns = "g-",
          toggle_float = false,
          edit_cell = "e",
          set_expression = "E",
          add_row = "a",
          duplicate_row = "A",
          review = "go",
        },
      },
    })

    keymap("n", "<F1>", ":Sqmeow toggle<CR>")
  end
}
