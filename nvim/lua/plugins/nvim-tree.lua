return {
  'nvim-tree/nvim-tree.lua',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', 'O', api.tree.expand_all, opts('Expand All'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
      vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
      vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab or Switch to Tab'))
      vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab or Switch to Tab'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    end

    local nvim_tree = require('nvim-tree')
    nvim_tree.setup {
      hijack_netrw = false,
      hijack_cursor = true,
      on_attach = on_attach,
      tab = {
        sync = {
          open = true,
          close = true,
          ignore = {},
        },
      },
      sort = {
        files_first = true,
      },
      view = {
        width = 40,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      actions = {
        open_file = {
          resize_window = false,
          -- quit_on_open = true,
        },
      },
      git = {
        ignore = false,
      },
      filters = {
        dotfiles = true,
      },
    }

    -- auto close
    local function tab_win_closed(winnr)
      local api = require('nvim-tree.api')
      local tabnr = vim.api.nvim_win_get_tabpage(winnr)
      local bufnr = vim.api.nvim_win_get_buf(winnr)
      local buf_info = vim.fn.getbufinfo(bufnr)[1]
      local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
      local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
      if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
        -- Close all nvim tree on :q
        if not vim.tbl_isempty(tab_bufs) then        -- and was not the last window (not closed automatically by code below)
          api.tree.close()
        end
      else                                                    -- else closed buffer was normal buffer
        if #tab_bufs == 1 then                                -- if there is only 1 buffer left in the tab
          local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
          if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
            vim.schedule(function()
              if #vim.api.nvim_list_wins() == 1 then          -- if its the last buffer in vim
                vim.cmd "quit"                                -- then close all of vim
              else                                            -- else there are more tabs open
                vim.api.nvim_win_close(tab_wins[1], true)     -- then close only the tab
              end
            end)
          end
        end
      end
    end

    vim.api.nvim_create_autocmd("WinClosed", {
      callback = function()
        local winnr = tonumber(vim.fn.expand("<amatch>"))
        vim.schedule_wrap(tab_win_closed(winnr))
      end,
      nested = true
    })

    -- keymap
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }
    keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

    -- color
    local api = vim.api
    api.nvim_set_hl(0, "NvimTreeFolderName", { ctermfg = 81 })
    api.nvim_set_hl(0, "NvimTreeRootFolder", { ctermfg = 245 })
    api.nvim_set_hl(0, "NvimTreeFolderIcon", { ctermfg = 110 })
    api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { ctermfg = 81 })
    api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { ctermfg = 81 })
    api.nvim_set_hl(0, "NvimTreeIndentMarker", { ctermfg = 245 })
    api.nvim_set_hl(0, "NvimTreeExecFile", { ctermfg = 118 })
    api.nvim_set_hl(0, "NvimTreeImageFile", { ctermfg = 161 })
    api.nvim_set_hl(0, "NvimTreeSpecialFile", { ctermfg = 208 })
  end,
}
