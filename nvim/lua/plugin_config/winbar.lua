local devicons = require('nvim-web-devicons')
local winbar_filetype_exclude = {
  "help",
  "lazy",
  "mason",
  "spectre_panel",
  "toggleterm",
  "TelescopePrompt",
  "TelescopeResults",
  "NvimTree",
  "tagbar",
}

local api = vim.api
api.nvim_create_autocmd("FileType", {
  pattern = '*',
  callback = function()
    if not vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
      local file = vim.fn.expand("%")
      local relative_path = vim.fn.substitute(file, vim.fn.getcwd() .. "/", "", "")
      local icon = devicons.get_icon(file)
      if icon == nil then
        icon = ""
      else
        icon = icon .. " "
      end
      vim.opt_local.winbar = "%=" .. icon .. relative_path:gsub('/', ' ➤ ') .. " %m"
    end
  end
})

api.nvim_set_hl(0, "WinBar", { cterm = none })
--api.nvim_set_hl(0, "WinBarNC", { ctermfg = 220, cterm = none })
