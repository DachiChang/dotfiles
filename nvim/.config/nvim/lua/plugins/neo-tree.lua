return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = true,
  version = '3.*',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "s1n7ax/nvim-window-picker",
  },
  config = function()
    local window_picker = require('window-picker')
    window_picker.setup({
      filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
          filetype = { "neo-tree", "neo-tree-popup", "notify" },
          buftype = { "terminal", "quickfix" },
        },
      },
    })

    local neo_tree = require('neo-tree')
    neo_tree.setup({
      sources = {
        "filesystem",
        "buffers",
      },
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      enable_git_status = false,
      log_level = "debug",
      log_to_file = false, -- "/tmp/neo-tree.log"
      popup_border_style = "rounded",
      use_default_mappings = false,
      default_component_configs = {
        container = {
          right_padding = 1,
        },
        modified = {
          symbol = "[+]",
        },
        file_size = {
          enabled = false,
        },
        type = {
          enabled = false,
        },
        last_modified = {
          enabled = false,
        },
      },
      window = {
        mappings = {
          ["<cr>"] = "open_with_window_picker",
          ["C"] = "close_all_subnodes",
          ["W"] = "close_all_nodes",
          ["O"] = "expand_all_subnodes",
          ["R"] = "refresh",
          ["e"] = {
            function(state)
              require("neo-tree.sources.filesystem.commands").toggle_auto_expand_width(state)
              local expand_status = state.window.auto_expand_width and "ON" or "Off"
              print("Auto expand width: " .. expand_status)
            end,
            desc = "toggle auto expand width",
          },
          ["s"] = "split_with_window_picker",
          ["v"] = "vsplit_with_window_picker",
          ["t"] = "open_tabnew",
          ["y"] = {
            function(state)
              local node = state.tree:get_node()
              vim.cmd(("let @+=%q"):format(node.name))
              print("Copy file name: " .. node.name)
            end,
            desc = "copy file name",
          },
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = true,
              use_image_nvim = false,
              title = "Neo-tree Preview",
            }
          },
          ["<"] = "prev_source",
          [">"] = "next_source",
          ["?"] = "show_help",
        },
      },
      filesystem = {
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ["<tab>"] = "toggle_hidden",
            ["a"] = "add",
            ["d"] = "delete",
            ["r"] = "rename",
            ["c"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["f"] = "filter_on_submit",
            ["q"] = "clear_filter",
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["i"] = "show_file_details",
            ["Y"] = {
              function(state)
                local node = state.tree:get_node()
                vim.cmd(("let @+=%q"):format(node.path))
                print("Copy file path: " .. node.path)
              end,
              desc = "Copy file path",
            },
            ["oc"] = "order_by_created",
            ["oe"] = "order_by_diagnostics",
            ["om"] = "order_by_modified",
            ["on"] = "order_by_name",
            ["os"] = "order_by_size",
            ["ot"] = "order_by_type",
          },
        },
      },
      buffers = {
        window = {
          mappings = {
            ["d"] = "buffer_delete",
          },
        },
      },
    })
    -- keymap
    local keymap = vim.keymap.set
    keymap("n", "<LEADER>e", ":Neotree toggle<CR>")
  end,
}
