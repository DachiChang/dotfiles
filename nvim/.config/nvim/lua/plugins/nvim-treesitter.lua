-- REQUIRED: brew install tree-sitter-cli
return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  branch = "main",
  build = ":TSUpdate", -- NOTE: will be updated parsers when this plugin is updated
  lazy = false,
  config = function()
    local nvim_treesitter = require('nvim-treesitter')
    -- treesitter supported languages map
    local supported_languages = {}
    for _, language in ipairs(nvim_treesitter.get_available()) do
      supported_languages[language] = true
    end

    -- active treesitter parsers
    local treesitter_setup_augroup = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      group = treesitter_setup_augroup,
      callback = function(args)
        local filetype = args.match
        local language = vim.treesitter.language.get_lang(filetype) or filetype

        -- try to add treesitter parser
        if not vim.treesitter.language.add(language) then
          -- language not installed
          if supported_languages[language] then
            -- language is supported by treesitter but not installed
            vim.notify(string.format("Treesitter parser missing: %s", language))
          end
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
