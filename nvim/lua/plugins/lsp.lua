return {
  'neovim/nvim-lspconfig', -- language server protocal client
  enabled = true,
  dependencies = {
    'williamboman/mason.nvim',           -- language server installer
    'williamboman/mason-lspconfig.nvim', -- bridge between client and mason
    'hrsh7th/nvim-cmp',                  -- completion
    'hrsh7th/cmp-nvim-lsp',              -- bridge lspconfig
    'ray-x/lsp_signature.nvim',          -- Show function signature when you type
  },
  config = function()
    local keymap = vim.keymap
    local buf = vim.lsp.buf
    local lsp_servers = { -- ensure installed language server
      "lua_ls",
      "html",
      "cssls",
      "emmet_ls",
      "gopls",
      "pyright",
      "tsserver",
      "jsonls",
      --  "yamlls",
      "helm_ls",
      "terraformls",
      "tflint",
      "csharp_ls",
    }

    local mason_installer = require('mason')
    mason_installer.setup {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }

    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup {
      ensure_installed = lsp_servers,
    }

    local lsp_signature = require('lsp_signature')
    lsp_signature.setup {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      hint_enable = false,
      handler_opts = {
        border = 'rounded',
      }
    }

    -- for each lsp-server setup
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
          keymap.set('n', 'gf', buf.format, bufopts) -- go format
        end
      end
    end

    local lsp_flags = {
      -- This is the default in Nvim 0.7+
      debounce_text_changes = 150,
    }

    -- for each lsp server, config lsp to assign capabilities for completion
    local lspconfig = require('lspconfig')
    for _, lsp_server in ipairs(lsp_servers) do
      lspconfig[lsp_server].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      }
    end

    -- override html lsp config
    lspconfig['html'].setup {
      --  https://code.visualstudio.com/Docs/languages/html
      settings = {
        html = {
          format = {
            extraLiners = "",
            indentInnerHtml = true,
          },
        },
      },
      capabilities = capabilities,
      on_attach = on_attach,
      flags = lsp_flags,
    }
    -- override yamlls lsp config
    -- lspconfig['yamlls'].setup {
    --   settings = {
    --     yaml = {
    --       keyOrdering = false,
    --     },
    --   },
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   flags = lsp_flags,
    -- }

    -- lsp handler
    local lsp = vim.lsp
    lsp.handlers['textDocument/hover'] = lsp.with(
      lsp.handlers.hover, {
        border = 'rounded',
      }
    )

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
  end,
}
