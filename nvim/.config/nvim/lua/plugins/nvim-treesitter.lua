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
        local buf = args.buf
        local language = vim.treesitter.language.get_lang(filetype) or filetype

        -- Try to load treesitter parser
        if not vim.treesitter.language.add(language) then
          -- language not installed
          if supported_languages[language] then
            -- language is supported by treesitter but not installed
            vim.notify(string.format("Treesitter parser missing: %s", language))
          end
          return
        end

        -- hightlight feature
        vim.treesitter.start(buf, language)
      end,
    })
  end
}
