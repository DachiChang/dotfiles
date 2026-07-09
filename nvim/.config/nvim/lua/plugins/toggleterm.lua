return {
  'akinsho/toggleterm.nvim',
  enabled = true,
  config = function()
    local toggleterm = require('toggleterm')
    local keymap = vim.keymap.set
    local function untoggle(term)
      vim.keymap.set({ "n", "t" }, "<leader><Esc>", function()
        term:toggle()
      end, { buffer = term.bufnr })
    end

    toggleterm.setup({
      direction = "float",
      float_opts = {
        border = 'curved',
      },
      on_open = untoggle, -- register <leader><Esc> keymap to untoggle
    })

    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      count = 10,
      hidden = true,
      direction = "float",
      on_open = untoggle,
    })

    -- toggle lazygit
    keymap({ "n", "t" }, "<leader>l", function()
      lazygit:toggle()
    end)

    -- toggle 1 ~ 9 terminal
    for i = 1, 9 do
      keymap({ "n", "t" }, string.format("<leader>%d", i), string.format("<cmd>ToggleTerm%d<cr>", i))
    end
  end,
}
