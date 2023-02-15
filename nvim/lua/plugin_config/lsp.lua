require('mason').setup { -- Mason installer config
  ui = {
    border = "single",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}
local lsp_servers = {
  "lua_ls",
  "html",
  "gopls",
  "pyright",
  "tsserver",
  "jsonls",
  "yamlls",
  "terraformls",
  "tflint",
}
require('mason-lspconfig').setup { -- mason lspconfig
  ensure_installed = lsp_servers,
}

-- shortcut variable
local keymap = vim.keymap
local diagnostic = vim.diagnostic
local buf = vim.lsp.buf
local inspect = vim.inspect
-- diagnostic keybind
local opts = { noremap = true, silent = true }
keymap.set('n', 'ep', diagnostic.goto_prev, opts)
keymap.set('n', 'en', diagnostic.goto_next, opts)

-- for each lsp-server setup
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap.set('n', 'gt', buf.hover, bufopts)
  keymap.set('n', 'gd', buf.definition, bufopts)
  keymap.set('n', 'gD', buf.declaration, bufopts)
  keymap.set('n', 'gi', buf.implementation, bufopts)
  keymap.set('n', 'gT', buf.type_definition, bufopts)
  keymap.set('n', 'gr', buf.references, bufopts)
  keymap.set('n', '<F2>', buf.rename, bufopts)

  local without_formatter = {
    'pyright', -- use vim-autopep8 instead, because pyright not support buffer formatter
  }
  for _, c in ipairs(without_formatter) do
    if c ~= client.name then
      keymap.set('n', '<F12>', function() buf.format { async = true } end, bufopts)
    end
  end
end
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
-- for each lsp server, assign capabilities for completion
for _, lsp_server in ipairs(lsp_servers) do
  lspconfig[lsp_server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
end
