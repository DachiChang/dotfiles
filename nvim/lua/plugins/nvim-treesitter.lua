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
      }
    }

    -- user treesitter to provider fold functional
    local opt = vim.opt
    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"
    opt.foldenable = true
    opt.foldlevelstart = 99
  end
}
