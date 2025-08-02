return {
  'karb94/neoscroll.nvim',
  enabled = true,
  config = function()
    local neoscroll = require('neoscroll')
    neoscroll.setup({
      mappings = { "zz", "zb", "zt" },
      hide_cursor = true,          -- 移動時是否顯示 cursor
      cursor_scrolls_alone = true, -- 即始視窗無法進一步捲動，cursor 是否可以移動
      duration_multiplier = 0.5,   -- 控制 duration 的 factor
      performance_mode = false,    -- 效能模式，用於大檔案與 syntax hightlight
    })
    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }
    keymap({ "n", "v", "x" }, "<C-u>", function()
      neoscroll.scroll(-10, { move_cursor = true, duration = 200 })
    end, default_opts)
    keymap({ "n", "v", "x" }, "<C-d>", function()
      neoscroll.scroll(10, { move_cursor = true, duration = 200 })
    end, default_opts)
  end,
}
