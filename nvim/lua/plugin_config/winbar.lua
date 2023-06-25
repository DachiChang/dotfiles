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
      local relative_path = vim.fn.substitute(vim.fn.expand("%"), vim.fn.getcwd() .. "/", "", "")
      vim.opt_local.winbar = "%=" .. relative_path:gsub('/', ' ➤ ') .. " %m"
    end
  end
})

api.nvim_set_hl(0, "WinBar", { cterm = none })
--api.nvim_set_hl(0, "WinBarNC", { ctermfg = 220, cterm = none })
