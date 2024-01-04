return {
  "HakonHarnes/img-clip.nvim",
  enabled = true,
  config = function()
    local img_clip = require("img-clip")
    img_clip.setup()
  end
}
