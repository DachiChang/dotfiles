-- Base64 decode, encode
return {
  "ovk/endec.nvim",
  enabled = true,
  config = function()
    require("endec").setup({
      keymaps = {
        -- disable all default keymap
        defaults = false,
        -- b64 b64URL URL encode/decode
        decode_base64_popup = "gbs",   -- base64 show
        decode_base64_inplace = "gbd", -- base64 decode
        encode_base64_inplace = "gbe", -- base64 encode
      },
    })
  end,
}
