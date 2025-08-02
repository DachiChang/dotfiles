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
          map = "<LEADER>r", -- default is <LEADER>rc
          cmd = "<CMD>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line"
        },
      },
    })

    local keymap = vim.keymap.set
    keymap("n", "<F6>", "<CMD>lua require('spectre').toggle()<CR>")
    keymap("n", "<LEADER>r", "<CMD>lua require('spectre').open_file_search({select_word=true})<CR>")
    keymap("v", "<LEADER>r", "<esc><CMD>lua require('spectre').open_file_search()<CR>")
  end,
}
