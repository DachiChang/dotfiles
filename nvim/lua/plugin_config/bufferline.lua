require("bufferline").setup {
  options = {
    mode = 'tabs',
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = { '', '' },
    indicator = {
      style = 'none',
    },
  },
  highlights = {
    fill = {
      ctermfg= 255,
      ctermbg = 236,
    },
    background = {
      ctermfg= 255,
      ctermbg = 236,
    },
    buffer_selected = {
      ctermfg= 255,
      ctermbg = 239,
    },
    indicator_selected = {
      ctermfg= 198,
      ctermbg = 239,
    },
    duplicate_selected = {
      ctermfg= 255,
      ctermbg = 239,
    },
    duplicate = {
      ctermfg= 255,
      ctermbg = 236,
    },
    modified_selected = {
      ctermfg = 196,
      ctermbg = 239,
    },
    modified = {
      ctermfg = 88,
      ctermbg = 236,
    },
  },
}
