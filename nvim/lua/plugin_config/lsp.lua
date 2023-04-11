require('mason').setup { -- Mason installer config
  ui = {
    border = "rounded",
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
local lsp_server_settings = {
  yamlls = {
    yaml = {
      keyOrdering = false,
    }
  }
}
require('mason-lspconfig').setup { -- mason lspconfig
  ensure_installed = lsp_servers,
}

local keymap = vim.keymap
local buf = vim.lsp.buf

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

  -- don't bind formatter
  local without_formatter = {
    'pyright', -- use vim-autopep8 instead, because pyright not support buffer formatter
  }
  for _, c in ipairs(without_formatter) do
    if c ~= client.name then
      keymap.set('n', '<F10>', function() buf.format { async = true } end, bufopts)
    end
  end

  -- binding lsp auto sigature
  require('lsp_signature').on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    hint_enable = false,
    handler_opts = {
      border = 'rounded',
    }
  }, bufnr)
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
    settings = lsp_server_settings[lsp_server]
  }
end

-- lsp handler
local lsp = vim.lsp
lsp.handlers['textDocument/hover'] = lsp.with(
  lsp.handlers.hover, {
    border = 'rounded',
  })

-- diagnostics
local diagnostic = vim.diagnostic
local opts = { noremap = true, silent = true }
diagnostic.config {
  float = {
    border = 'rounded',
  }
}
keymap.set('n', 'ge', diagnostic.open_float, opts)
keymap.set('n', 'ep', diagnostic.goto_prev, opts)
keymap.set('n', 'en', diagnostic.goto_next, opts)

-- color
local api = vim.api
api.nvim_set_hl(0, "NormalFloat", { ctermbg = 234 })
api.nvim_set_hl(0, "FloatBorder", { ctermbg = 234 })
api.nvim_set_hl(0, "LspSignatureActiveParameter", { bold = true, ctermbg = 52 })
