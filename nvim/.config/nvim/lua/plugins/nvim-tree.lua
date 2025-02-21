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
        width = 40,
      },
      renderer = {
        root_folder_label = ':t',
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
