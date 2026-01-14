return {
  "kazhala/close-buffers.nvim",
  enabled = true,
  config = function()
    local close_buffers = require("close_buffers")
    close_buffers.setup()

    local keymap = vim.keymap.set

    keymap("n", "<LEADER>c", function()
      local now_buffer_count = #vim.fn.getbufinfo({ buflisted = 1 })
      close_buffers.delete({ type = 'hidden', force = true })
      local after_clean_buffer_count = #vim.fn.getbufinfo({ buflisted = 1 })
      vim.notify(string.format(
        "Clean up unused buffers: %d -> %d, clean up %d buffers",
        now_buffer_count,
        after_clean_buffer_count,
        now_buffer_count - after_clean_buffer_count
      ))
    end)
  end,
}
