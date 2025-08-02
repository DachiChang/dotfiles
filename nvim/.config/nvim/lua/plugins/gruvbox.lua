return {
  'ellisonleao/gruvbox.nvim',
  enabled = true,
  priority = 1000,
  config = function()
    local gruvbox_theme = require('gruvbox')
    gruvbox_theme.setup({
      transparent_mode = false,
      terminal_colors = false,
      palette_overrides = {
        dark0 = "#1c1c1c",
        light1 = "#cac5b5",
      },
      overrides = {
        Directory = { link = "GruvboxBlueBold" },
        WinBar = { fg = "#A89984", bg = "none" },
        WinBarNC = { fg = "#A89984", bg = "none" },
        WinbarDelete = { bg = "none" },
        TabLineFill = { fg = "#cac5b5", bg = "#282828" },
        TabLine = { fg = "#cac5b5", bg = "#282828" },
        TabLineSel = { fg = "#ebdbb2", bg = "#504945" },
        CursorLine = { bg = "#444444" },
        CursorLineNr = { bg = "#444444" },
        FlashLabel = { bg = "#458588" },
        NvimTreeWindowPicker = { fg = "#1c1c1c" },
        TreesitterContext = { bg = "#504945" },
        BlinkCmpMenu = { bg = "#3B3837" },
        BlinkCmpMenuBorder = { bg = "#3B3837" },
        BlinkCmpMenuSelection = { bg = "#665C54", fg = "none" },
      },
    })
    vim.cmd("colorscheme gruvbox")
  end
}
