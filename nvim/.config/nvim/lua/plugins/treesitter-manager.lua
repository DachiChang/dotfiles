-- REQUIRED: brew install tree-sitter-cli
return {
  'romus204/tree-sitter-manager.nvim',
  enabled = true,
  config = function()
    local tree_sitter_manager = require('tree-sitter-manager')
    tree_sitter_manager.setup({
      auto_install = true,
      highlight = false, -- Self active for runtime highlight after parser installed.
    })

    -- Active treesitter
    local treesitter_setup_augroup = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      group = treesitter_setup_augroup,
      callback = function(args)
        local filetype = args.match
        local buf = args.buf
        -- Get filetype registered language
        local language = vim.treesitter.language.get_lang(filetype)

        -- Try to load treesitter parser
        if vim.treesitter.language.add(language) then
          vim.treesitter.start(buf, language)
        end
      end,
    })
  end
}
