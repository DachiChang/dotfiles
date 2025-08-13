return {
  'dachichang/luatab.nvim',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local luatab = require('luatab')

    luatab.setup({
      filterFileType = {
        "TelescopePrompt",
        "TelescopeResults",
        "help",
        "lazy",
        "mason",
        "neo-tree",
        "spectre_panel",
        "toggleterm",
      },
    })
  end,
}
