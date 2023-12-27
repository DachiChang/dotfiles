return {
  'Exafunction/codeium.vim',
  enabled = true,
  config = function()
    local default_opts = { expr = true, noremap = true, silent = true }
    local keymap = vim.keymap.set
    local fn = vim.fn
    local g = vim.g

    g.codeium_disable_bindings = 1

    keymap('i', '<C-y>', function()
      return fn['codeium#Accept']()
    end, default_opts)

    keymap('i', '<C-x>', function()
      return fn['codeium#Clear']()
    end, default_opts)

    keymap('i', "<M-]>", function()
      return fn['codeium#CycleCompletions'](1)
    end, default_opts)

    keymap('i', "<M-[", function()
      return fn['codeium#CycleCompletions'](-1)
    end, default_opts)
  end
}
