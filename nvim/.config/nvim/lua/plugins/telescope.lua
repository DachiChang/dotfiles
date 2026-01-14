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
    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden', -- include hidden
        },
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
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      }
    })
    keymap("n", "<LEADER>f", "<CMD>Telescope find_files hidden=true no_ignore=true<CR>")
    keymap("n", "<LEADER>g", "<CMD>Telescope live_grep<CR>")
    keymap("n", "<LEADER>h", "<CMD>Telescope help_tags<CR>")
    keymap("n", "<LEADER>k", "<CMD>Telescope keymaps<CR>")
    keymap("n", "<LEADER>w", "<CMD>Telescope grep_string<CR>")
    keymap("n", "<LEADER>b", "<CMD>Telescope buffers<CR>")
  end,
}
