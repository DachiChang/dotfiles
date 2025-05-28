return {
  'sphamba/smear-cursor.nvim',
  enabled = true,
  config = function()
    require('smear_cursor').setup {
      cursor_color = '#d3cdc3',
    }
  end
}
