return {
  "rmagatti/auto-session",
  enabled = true,
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_restore = false,
    })

    -- `vim.o.sessionoptions` should contain 'localoptions' to make sure
    -- filetype and highlighting work correctly after a session is restored.
    vim.opt.sessionoptions:append("localoptions")

    local keymap = vim.keymap.set

    keymap("n", "<LEADER><BS>", ":AutoSession restore<CR>") -- back
  end,
}
