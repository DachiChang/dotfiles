return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  branch = "main",
  lazy = false,
  build = ":TSUpdate", -- NOTE: will be updated parsers when this plugin is updated
  config = function()
    local treesitter = require('nvim-treesitter')
    local parsers = {
      'bash',
      'css',
      'csv',
      'dockerfile',
      'go',
      'gomod',
      'gosum',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'python',
      'sql',
      'ssh_config',
      'templ',
      'terraform',
      'toml',
      'tsv',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
      'zsh',
    }
    treesitter.install(parsers)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = parsers,
      callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        -- indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end
}
