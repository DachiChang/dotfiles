return {
  'nvim-tree/nvim-tree.lua',
  enabled = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local api = require('nvim-tree.api')
    local function on_attach(bufnr)
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- NOTE: disable default keymap setting
      -- api.config.mappings.default_on_attach(bufnr)

      local keymap = vim.keymap.set

      keymap("n", ".", api.tree.change_root_to_node, opts("CD"))
      keymap("n", "<CR>", api.node.open.edit, opts("Open"))
      keymap('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
      keymap("n", "?", api.tree.toggle_help, opts("Help"))
      keymap("n", "F", api.live_filter.clear, opts("Live Filter: Clear"))
      keymap("n", "h", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
      keymap("n", "O", api.tree.expand_all, opts("Expand All"))
      keymap("n", "W", api.tree.collapse_all, opts("Collapse All"))
      keymap("n", "R", api.tree.reload, opts("Refresh"))
      keymap("n", "Y", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
      keymap("n", "a", api.fs.create, opts("Create File Or Directory"))
      keymap("n", "c", api.fs.copy.node, opts("Copy"))
      keymap("n", "d", api.fs.remove, opts("Delete"))
      keymap("n", "f", api.live_filter.start, opts("Live Filter: Start"))
      keymap("n", "i", api.node.show_info_popup, opts("Info"))
      keymap("n", "p", api.fs.paste, opts("Paste"))
      keymap("n", "q", api.tree.close, opts("Close"))
      keymap("n", "r", api.fs.rename, opts("Rename"))
      keymap("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
      keymap("n", "t", api.node.open.tab, opts("Open: New Tab"))
      keymap("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
      keymap("n", "x", api.fs.cut, opts("Cut"))
      keymap("n", "y", api.fs.copy.filename, opts("Copy Name"))
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
        signcolumn = "no",
        width = 40,
      },
      renderer = {
        root_folder_label = function(path)
          local folder_name = vim.fn.fnamemodify(path, ":t")
          return "  " .. string.upper(folder_name)
        end,
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            git = false,
          },
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

    -- sync cursor between tab
    local position = { 1, 0 }
    local nvim_tree_event = api.events.Event
    api.events.subscribe(nvim_tree_event.TreeRendered, function(event) -- 當 tree rendered 時重新對齊 cursor
      vim.api.nvim_win_set_cursor(event.winnr, position)
      -- vim.notify("Event set cursor" .. vim.inspect(position), vim.log.levels.WARN)
    end)

    local cursor_sync_group = vim.api.nvim_create_augroup("NvimTreeCursorSync", { clear = true })
    vim.api.nvim_create_autocmd("CursorMoved", { -- 記錄 NvimTree 中 cursor 位置
      group = cursor_sync_group,
      pattern = "NvimTree_*",
      callback = function()
        position = vim.api.nvim_win_get_cursor(0)
        -- vim.notify("Save cursor" .. vim.inspect(position), vim.log.levels.INFO)
      end
    })

    vim.api.nvim_create_autocmd("TabEnter", {
      group = cursor_sync_group,
      pattern = "NvimTree_*",
      callback = function()
        -- NOTE: 如果都是在主視窗編輯切換 Tab 會讓 Event.TreeRendered 自設定 position 沒問題
        -- 但是當 focus 在 NvimTree 的時候，切換 Tab 因為設定了 CursorMoved 因此會重新記錄 position
        -- 這導致了在 focus NvimTree 相互切換時，Cursor 會一直先被重設為該 Buf 的 Cursor ，等於沒有同步
        -- 優先叫用 tree.reload() 會觸發前面定義的 set cursor 這優先於 CursorMoved 所以可以正確同步
        api.tree.reload()
        -- vim.notify("TabEnter trigger tree reload" .. vim.inspect(position), vim.log.levels.ERROR)
      end
    })

    -- auto close
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
      pattern = "NvimTree_*",
      callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then
          vim.cmd("confirm quit")
        end
      end
    })

    -- keymap
    local keymap = vim.keymap.set
    keymap("n", "<LEADER>e", ":NvimTreeToggle<CR>")
  end,
}
