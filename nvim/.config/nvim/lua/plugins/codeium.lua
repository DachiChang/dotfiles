return {
  'Exafunction/codeium.vim',
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

    -- toggle codeium on F1
    keymap("n", "<F1>", ":Codeium Toggle<CR>")
  end
}
