require('luatab').setup {
  windowCount = function()
    return ''
  end,
  title = function(bufnr)
    local file = vim.fn.bufname(bufnr)
    local buftype = vim.fn.getbufvar(bufnr, '&buftype')
    local filetype = vim.fn.getbufvar(bufnr, '&filetype')

    if buftype == 'help' then
      return 'help:' .. vim.fn.fnamemodify(file, ':t:r')
    elseif filetype == 'TelescopePrompt' then
      return 'Telescope'
    elseif filetype == 'NvimTree' then
      return 'NvimTree'
    elseif filetype == 'tagbar' then
      return 'TagBar'
    elseif buftype == 'terminal' then
      local _, mtch = string.match(file, "term:(.*):(%a+)")
      return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ':t')
    elseif file == '' then
      return '[No Name]'
    else
      return vim.fn.pathshorten(vim.fn.fnamemodify(file, ':p:~:t'))
    end
  end
}

-- tabline
local api = vim.api
api.nvim_set_hl(0, "TabLineFill", { ctermfg = 255, ctermbg = 236 })
api.nvim_set_hl(0, "TabLine", { ctermfg = 255, ctermbg = 236 })
api.nvim_set_hl(0, "TabLineSel", { bold = true, ctermfg = 255, ctermbg = 239 })
