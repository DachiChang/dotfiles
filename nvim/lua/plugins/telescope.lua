-- REQUIRED: brew install ripgrep
return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local keymap = vim.keymap.set
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local builtin = require('telescope.builtin')
    telescope.setup {
      defaults = {
        mappings = {
          n = {
            ['t'] = actions.select_tab,
            ['v'] = actions.select_vertical,
            ['s'] = actions.select_horizontal,
          },
          i = {
            ['<C-t>'] = actions.select_tab,
            ['<C-v>'] = actions.select_vertical,
            ['<C-s>'] = actions.select_horizontal,
          },
        },
        preview = {
          treesitter = false,
        },
      }
    }
    keymap("n", "<leader>f", function()
      builtin.find_files({ hidden = true })
    end, {})
    keymap("n", "<leader>g", builtin.live_grep, {})
    keymap("n", "<leader>h", builtin.help_tags, {})
    keymap("n", "<leader>k", builtin.keymaps, {})
    keymap("n", "<leader>b", builtin.buffers, {})

    -- color style
    local api = vim.api
    api.nvim_set_hl(0, "TelescopeSelection", { ctermbg = 238 })
  end,
}
