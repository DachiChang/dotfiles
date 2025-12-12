return {
  'ellisonleao/carbon-now.nvim',
  enabled = true,
  config = function()
    local carbon = require('carbon-now')
    carbon.setup({
      base_url = "https://carbon.now.sh/",
      open_cmd = "open",
      options = {
        bg = "#B6A292",
        drop_shadow_blur = "68px",
        drop_shadow = true,
        drop_shadow_offset_y = "20px",
        font_family = "Hack",
        font_size = "18px",
        line_height = "133%",
        line_numbers = true,
        theme = "zenburn",
        titlebar = "",
        watermark = false,
        width = "680",
        window_theme = "bw",
        padding_horizontal = "50px",
        padding_vertical = "50px",
      },
    })

    -- toggle Code snapshoot on F4
    local keymap = vim.keymap.set
    keymap({ "n", "v" }, "<F4>", "<CMD>CarbonNow<CR>")
  end
}
