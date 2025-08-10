return {
  "rmagatti/auto-session",
  enabled = true,
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_restore = false,
    })

    local keymap = vim.keymap.set

    keymap("n", "<LEADER>b", ":SessionRestore<CR>") -- back
  end,
}
