return {
  "kazhala/close-buffers.nvim",
  enabled = true,
  config = function()
    local close_buffers = require("close_buffers")
    close_buffers.setup()

    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = false }

    keymap("n", "<LEADER>c", function()
      close_buffers.delete({ type = 'hidden', force = true })
      vim.notify("Clean up unused buffers")
    end, default_opts)
  end,
}
