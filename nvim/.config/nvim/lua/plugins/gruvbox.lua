return {
  'ellisonleao/gruvbox.nvim',
  enabled = true,
  priority = 1000,
  config = function()
    require("gruvbox").setup {
      terminal_colors = false,
      palette_overrides = {
        dark0 = "#1c1c1c",
        light1 = "#cac5b5",
      },
      overrides = {
        WinBar = { fg = "#cac5b5", bg = "#1c1c1c" },
        WinBarNC = { fg = "#cac5b5", bg = "#1c1c1c" },
        WinbarDelete = { bg = "#1c1c1c" },
        TabLineFill = { fg = "#cac5b5", bg = "#282828" },
        TabLine = { fg = "#cac5b5", bg = "#282828" },
        TabLineSel = { fg = "#b8bb26", bg = "#3c3836" },
        CursorLine = { bg = "#444444" },
        CursorLineNr = { bg = "#444444" },
        FlashLabel = { bg = "#458588" },
        NvimTreeWindowPicker = { fg = "#1c1c1c" },
      },
    }
    vim.cmd("colorscheme gruvbox")
  end
}
