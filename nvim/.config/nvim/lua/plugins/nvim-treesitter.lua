return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  build = ":TSUpdate", -- NOTE: will be updated parsers when this plugin is updated
  config = function()
    local treesitter_config = require('nvim-treesitter.configs')
    treesitter_config.setup({
      auto_install = true, -- auto install the missing parse when enter the buffer
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<Space>',
          node_incremental = '<Space>',
          scope_incremental = false,
          node_decremental = '<BS>',
        },
      },
    })

    -- use treesitter to provider fold functional
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldtext = ""
    vim.opt.foldenable = true
    vim.opt.foldlevelstart = 99

    -- disable fold for certain filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "toggleterm",
      },
      callback = function()
        vim.opt_local.foldmethod = "manual"
      end,
    })
  end
}
