-- Base64 decode, encode
return {
  "ovk/endec.nvim",
  enabled = true,
  config = function()
    require("endec").setup({
      keymaps = {
        -- b64 b64URL URL encode/decode
        decode_base64_popup = "gs",   -- base64 show
        decode_base64_inplace = "gbd", -- base64 decode
        encode_base64_inplace = "gbe", -- base64 encode

        -- disable base64 url encode/decode
        decode_base64url_popup = "",   -- base64 url show
        decode_base64url_inplace = "", -- base64 url decode
        encode_base64url_inplace = "", -- base64 url encode

        -- disable url encode/decode
        decode_url_popup = "",   -- url show
        decode_url_inplace = "", -- url decode
        encode_url_inplace = "", -- url encode
      },
    })
  end,
}
