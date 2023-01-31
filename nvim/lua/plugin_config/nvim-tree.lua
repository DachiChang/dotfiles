require('nvim-tree').setup{
  hijack_netrw = false,
  hijack_cursor = true,
  view = {
    mappings = {
      list = {
        { key = "O", action = "expand_all"},
        { key = "v", action = "vsplit"},
        { key = "s", action = "split"},
        { key = "t", action = "tabnew"},
      }
    }
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

-- color
local api = vim.api
api.nvim_set_hl(0, "NvimTreeFolderName", { ctermfg=81 })
api.nvim_set_hl(0, "NvimTreeRootFolder", { ctermfg=245 })
api.nvim_set_hl(0, "NvimTreeFolderIcon", { ctermfg=110 })
api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { ctermfg=81 })
api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { ctermfg=81 })
api.nvim_set_hl(0, "NvimTreeIndentMarker", { ctermfg=245 })
api.nvim_set_hl(0, "NvimTreeExecFile", { ctermfg=118 })
api.nvim_set_hl(0, "NvimTreeImageFile", { ctermfg=161 })
api.nvim_set_hl(0, "NvimTreeSpecialFile", { ctermfg=208 })
