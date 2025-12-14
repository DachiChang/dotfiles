return {
  'nvim-pack/nvim-spectre',
  enabled = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local spectre = require('spectre')
    spectre.setup({
      live_update = true,
      replace_engine = {
        ['sed'] = {
          cmd = "sed",
          args = {
            '-i',
            '',
          },
        },
      },
      mapping = {
        ['run_current_replace'] = {
          map = 'r',
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = 'replace item',
        },
        ['run_replace'] = {
          map = 'R',
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = 'replace all',
        },
      },
    })

    local keymap = vim.keymap.set
    keymap("n", "<LEADER>r", "<CMD>lua require('spectre').open_file_search({select_word=true})<CR>")
    keymap("v", "<LEADER>r", "<esc><CMD>lua require('spectre').open_file_search()<CR>")
  end,
}
