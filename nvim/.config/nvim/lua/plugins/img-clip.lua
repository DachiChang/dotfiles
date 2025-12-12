-- REQUIRED: brew install pngpaste
return {
  "HakonHarnes/img-clip.nvim",
  enabled = true,
  config = function()
    local img_clip = require('img-clip')
    img_clip.setup()

    -- toggle Image Paste on F3
    local keymap = vim.keymap.set
    keymap("n", "<F3>", "<CMD>PasteImage<CR>")
  end
}
