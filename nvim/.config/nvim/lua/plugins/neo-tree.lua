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
      picker_config = {
        handle_mouse_click = true,
      },
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
      clipboard = {
        sync = "universal", -- or "global"/"universal" to share a clipboard for each/all Neovim instance(s), respectively
      },
      close_if_last_window = true,
      log_level = "debug",
      log_to_file = false, -- "/tmp/neo-tree.log"
      popup_border_style = "rounded",
      use_default_mappings = false,
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function(_)
            vim.cmd("wincmd =")
          end
        },
      },
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
          ["<Space>"] = "open_with_window_picker",
          ["<2-LeftMouse>"] = "open_with_window_picker",
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
          ["?"] = "show_help",
        },
      },
      filesystem = {
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_by_pattern = {
            "*_templ.go", -- _templ.go 是由 templ 產生的檔案，不需要在 Neo-Tree 中顯示
          },
        },
        window = {
          mappings = {
            ["<Tab>"] = "toggle_hidden",
            ["a"] = "add",
            ["d"] = "delete",
            ["e"] = "rename",
            ["c"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["<C-c>"] = "clear_clipboard",
            ["f"] = "filter_on_submit",
            ["q"] = "clear_filter",
            ["u"] = "navigate_up",
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
    keymap("n", "<LEADER>R", "<CMD>Neotree reveal<CR>")
  end,
}
