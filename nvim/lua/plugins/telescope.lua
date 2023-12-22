-- REQUIRED: brew install ripgrep
return {
  'nvim-telescope/telescope.nvim',
  enabled = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }
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
      }
    }
    keymap("n", "<leader>f", function()
      builtin.find_files({ hidden = true })
    end, default_opts)
    keymap("n", "<leader>g", builtin.live_grep, default_opts)
    keymap("n", "<leader>h", builtin.help_tags, default_opts)
    keymap("n", "<leader>k", builtin.keymaps, default_opts)
    keymap("n", "<leader>b", builtin.buffers, default_opts)
  end,
}
