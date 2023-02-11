require('lualine').setup {
  options = {
    theme = 'gruvbox-material',
    globalstatus = true,
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 2, -- show full path
      }
    },
  },
}
