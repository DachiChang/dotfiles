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
      },
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
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
        name = {
          use_git_status_colors = false,
        },
        git_status = {
          symbols = {
            untracked = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "",
          },
          align = "right",
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
          ["<CR>"] = "open_with_window_picker",
          ["C"] = "close_all_subnodes",
          ["W"] = "close_all_nodes",
          ["O"] = "expand_all_subnodes",
          ["r"] = "refresh",
          ["+"] = {
            function(state)
              require("neo-tree.sources.filesystem.commands").toggle_auto_expand_width(state)
              local expand_status = state.window.auto_expand_width and "On" or "Off"
              vim.notify("Auto expand width: " .. expand_status)
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
              vim.notify("Copy file name: " .. node.name)
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
            ["<Tab>"] = "toggle_hidden",
            ["a"] = "add",
            ["d"] = "delete",
            ["e"] = "rename",
            ["c"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["f"] = "filter_on_submit",
            ["q"] = "clear_filter",
            ["<BS>"] = "navigate_up",
            ["."] = "set_root",
            ["i"] = "show_file_details",
            ["Y"] = {
              function(state)
                local node = state.tree:get_node()
                vim.cmd(("let @+=%q"):format(node.path))
                vim.notify("Copy file path: " .. node.path)
              end,
              desc = "Copy file path",
            },
            ["<LEADER>r"] = {
              function(state)
                local node = state.tree:get_node()

                local relative_path = ""
                if node.path ~= state.path then
                  relative_path = node.path:sub(#state.path + 2)
                end

                local search_path = ({
                  directory = relative_path == "" and "**" or (relative_path .. "/**"),
                  file      = relative_path,
                })[node.type]

                if not search_path then
                  vim.notify("Not support search/replace file type")
                  return
                end

                require('spectre').open({ path = search_path })
              end,
              desc = "Search and replace",
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
    })
    -- keymap
    local keymap = vim.keymap.set
    keymap("n", "<LEADER>e", "<CMD>Neotree toggle<CR>")
  end,
}
