return {
  'akinsho/toggleterm.nvim',
  enabled = true,
  config = function()
    local toggleterm = require('toggleterm')
    local keymap = vim.keymap.set
    local function untoggle(term)
      vim.keymap.set({ "n", "t" }, "<LEADER><ESC>", function()
        term:toggle()
      end, { buffer = term.bufnr })
    end

    toggleterm.setup({
      direction = "float",
      autochdir = true,
      float_opts = {
        border = 'curved',
      },
      on_open = untoggle, -- register <LEADER><ESC> keymap to untoggle
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
    keymap({ "n", "t" }, "<LEADER>l", function()
      lazygit:toggle()
    end)

    -- toggle 1 ~ 9 terminal
    for i = 1, 9 do
      -- In Terminal mode, : is forwarded to the shell as a literal character
      -- Whereas <Cmd> is a pseudokey that Neovim intercepts and executes as an Ex command directly, without ever entering Command-line mode.
      keymap({ "n", "t" }, string.format("<LEADER>%d", i), string.format("<CMD>ToggleTerm%d<CR>", i))
    end
  end,
}
