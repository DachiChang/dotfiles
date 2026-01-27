return {
  'Exafunction/windsurf.vim',
  enabled = true,
  init = function()
    local g = vim.g

    g.codeium_disable_bindings = 1
    g.codeium_manual = true
    g.codeium_filetypes = {
      TelescopePrompt = false,
    }
  end,
  config = function()
    local keymap = vim.keymap.set
    local fn = vim.fn

    keymap("i", "<C-y>", function()
      return fn["codeium#Accept"]()
    end, { expr = true })

    keymap("i", "<C-x>", function()
      return fn["codeium#Clear"]()
    end, { expr = true })

    keymap("i", "<C-o>", function()
      return fn["codeium#CycleOrComplete"]()
    end, { expr = true })

    -- codeium manual/auto switcher
    keymap("n", "<S-Tab>", function()
      local manual_mode = vim.g.codeium_manual or false
      if manual_mode then
        vim.g.codeium_manual = false -- switch to auto
        vim.notify("Codeium: Auto Mode")
      else
        vim.g.codeium_manual = true -- switch to manual
        vim.notify("Codeium: Manual Mode")
      end
    end)
  end
}
