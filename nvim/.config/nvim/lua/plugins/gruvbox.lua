return {
  'ellisonleao/gruvbox.nvim',
  enabled = true,
  priority = 1000,
  config = function()
    local gruvbox_theme = require('gruvbox')
    gruvbox_theme.setup({
      transparent_mode = true,
      terminal_colors = false,
      palette_overrides = {
        dark0 = "#1c1c1c",
        light1 = "#cac5b5",
      },
      overrides = {
        WinBar = { fg = "#A89984", bg = "none" },
        WinBarNC = { fg = "#A89984", bg = "none" },
        WinbarDelete = { bg = "none" },
        TabLineFill = { fg = "#cac5b5" },
        TabLine = { fg = "#cac5b5" },
        TabLineSel = { fg = "#f2e5bc", bg = "#504945" },
        CursorLine = { bg = "#444444" },
        CursorLineNr = { bg = "#444444" },
        DiffText = { bg = "#f78b7f" },
        FlashLabel = { bg = "#458588" },
        TreesitterContext = { bg = "#504945" },
        BlinkCmpMenu = { bg = "#3B3837" },
        BlinkCmpMenuBorder = { bg = "#3B3837" },
        BlinkCmpMenuSelection = { bg = "#665C54", fg = "none" },
        WindowPickerStatusLineNC = { bg = "#8ec07c", fg = "#1c1c1c" },
        NeoTreeDirectoryIcon = { fg = "#fabd2f" },
        NeoTreeDirectoryName = { fg = "#ebdbb2" },
        NeoTreeDimText = { fg = "#928374" },
      },
    })
    vim.cmd("colorscheme gruvbox")
  end
}
