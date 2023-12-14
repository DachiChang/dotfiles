return {
  'nvim-tree/nvim-web-devicons',
  enabled = true,
  config = function()
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
          local file_absolute_dir = vim.fn.expand("%:p:h")
          local file_name = vim.fn.expand("%:t")
          local relative_path = vim.fn.substitute(file_absolute_dir, vim.fn.getcwd(), "", "")
          local icon = devicons.get_icon(file_absolute_dir .. "/" .. file_name)
          if icon == nil then
            icon = ""
          else
            icon = icon .. " "
          end
          -- trim the start root slash and replace / to > and append icon and append filename.
          local file_path = ""
          if string.len(relative_path) ~= 0 then
            file_path = relative_path:gsub('^/', ''):gsub('/', ' ➤ ') .. " ➤ "
          end

          vim.opt_local.winbar = " " .. file_path .. icon .. file_name .. " %m%#WinbarDelete#"
        end
      end
    })

    -- api.nvim_set_hl(0, "WinBar", { cterm = none })
    api.nvim_set_hl(0, "WinbarDelete", { ctermbg = 234 })
    api.nvim_set_hl(0, "Winbar", { ctermbg = 52 })
    -- api.nvim_set_hl(0, "WinBarNC", { ctermbg = 52 })
  end,
}
