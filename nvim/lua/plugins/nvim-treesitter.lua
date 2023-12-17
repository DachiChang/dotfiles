return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  config = function()
    local tree_parser = {
      "bash",
      "css",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "python",
      "scss",
      "sql",
      "terraform",
      "vim",
      "yaml",
    }

    require 'nvim-treesitter.configs'.setup {
      ensure_installed = tree_parser,
      auto_install = true,
      highlight = {
        enable = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '+',
          node_incremental = '+',
          scope_incremental = false,
          node_decremental = '_',
        },
      },
    }

    -- user treesitter to provider fold functional
    local opt = vim.opt
    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"
    opt.foldenable = true
    opt.foldlevelstart = 99

    -- enable highlight on F4
    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }
    keymap("n", "<F4>", ":TSBufToggle highlight<CR>", default_opts)
  end
}
