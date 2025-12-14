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
    local default_opts = { expr = true, noremap = true, silent = true }
    local keymap = vim.keymap.set
    local fn = vim.fn

    keymap("i", "<C-y>", function()
      return fn["codeium#Accept"]()
    end, default_opts)

    keymap("i", "<C-x>", function()
      return fn["codeium#Clear"]()
    end, default_opts)

    keymap("i", "<C-o>", function()
      return fn["codeium#CycleOrComplete"]()
    end, default_opts)

    -- codeium manual/auto switcher
    keymap("n", "<F1>", function()
      local manual_mode = vim.g.codeium_manual or false
      if manual_mode then
        vim.g.codeium_manual = false -- switch to auto
        print("Codeium: Auto Mode")
      else
        vim.g.codeium_manual = true -- switch to manual
        print("Codeium: Manual Mode")
      end
    end, default_opts)
  end
}
