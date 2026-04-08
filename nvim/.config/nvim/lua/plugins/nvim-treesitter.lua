-- REQUIRED: brew install tree-sitter-cli
return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  branch = "main",
  build = ":TSUpdate", -- NOTE: will be updated parsers when this plugin is updated
  lazy = false,
  config = function()
    local treesitter_setup_augroup = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      group = treesitter_setup_augroup,
      callback = function(args)
        local filetype = args.match

        local language = vim.treesitter.language.get_lang(filetype) or filetype
        if not vim.treesitter.language.add(language) then
          return
        end

        -- hightlight feature
        vim.treesitter.start()
        -- fold feature
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- indent feature
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end
}
