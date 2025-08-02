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
        "help",
        "lazy",
        "mason",
        "spectre_panel",
        "toggleterm",
        "TelescopePrompt",
        "TelescopeResults",
        "NvimTree",
        "tagbar",
      },
    })
  end,
}
