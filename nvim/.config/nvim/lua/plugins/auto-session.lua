return {
  "rmagatti/auto-session",
  enabled = true,
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_save_enabled = false,
      auto_restore_enabled = false,
    })

    local keymap = vim.keymap.set

    keymap("n", "<leader>sr", ":SessionRestore<CR>")
    keymap("n", "<leader>ss", ":SessionSave<CR>")
  end,
}
