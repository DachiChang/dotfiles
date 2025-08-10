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
          '-u' -- no-ignore
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
    keymap("n", "<LEADER>f", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true,
      })
    end, default_opts)
    keymap("n", "<LEADER>g", builtin.live_grep, default_opts)
    keymap("n", "<LEADER>h", builtin.help_tags, default_opts)
    keymap("n", "<LEADER>s", function()
      builtin.lsp_document_symbols({
        symbol_width = 50,
      })
    end, default_opts)
    keymap("n", "<LEADER>k", builtin.keymaps, default_opts)
    keymap("n", "<LEADER>w", builtin.grep_string, default_opts)
  end,
}
