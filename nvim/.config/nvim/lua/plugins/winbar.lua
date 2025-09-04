return {
  'nvim-tree/nvim-web-devicons',
  enabled = true,
  config = function()
    local devicons = require('nvim-web-devicons')
    local winbar_filetype_exclude = {
      "TelescopePrompt",
      "TelescopeResults",
      "help",
      "lazy",
      "mason",
      "spectre_panel",
      "toggleterm",
      "dbui",
      "dbout",
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = '*',
      callback = function()
        local win_config = vim.api.nvim_win_get_config(vim.api.nvim_get_current_win())
        if not vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) and win_config.relative ~= "win" then
          local file_name = vim.fn.expand("%:t")
          if file_name == "" then
            return
          end

          local file_absolute_dir = vim.fn.expand("%:p:h")
          local relative_path = vim.fn.substitute(file_absolute_dir, vim.fn.getcwd(), "", "")
          local icon_str = ""
          local icon = devicons.get_icon(file_name)
          if icon ~= nil then
            icon_str = icon .. " "
          end
          -- trim the start root slash and replace / to > and append icon and append filename.
          local file_path = ""
          if string.len(relative_path) ~= 0 then
            file_path = relative_path:gsub('^/', ''):gsub('/', ' ➤ ') .. " ➤ "
          end

          vim.opt_local.winbar = " " .. file_path .. icon_str .. file_name .. " %m%#WinbarDelete#"
        end
      end
    })
  end,
}
