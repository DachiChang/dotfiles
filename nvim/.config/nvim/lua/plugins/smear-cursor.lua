return {
  'sphamba/smear-cursor.nvim',
  enabled = false,
  config = function()
    require('smear_cursor').setup({
      cursor_color = '#d3cdc3',
      smear_to_cmd = false, -- fix show code action redraw bug
    })
  end
}
