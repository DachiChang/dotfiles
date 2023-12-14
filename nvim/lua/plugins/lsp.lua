return {
  'williamboman/mason.nvim', -- mason lsp and tools manager
  enabled = true,
  dependencies = {
    'williamboman/mason-lspconfig.nvim',         -- bridge between client and mason
    'WhoIsSethDaniel/mason-tool-installer.nvim', -- auto install mason tools
    'neovim/nvim-lspconfig',                     -- language server protocal client
    'hrsh7th/cmp-nvim-lsp',                      -- bridge lspconfig
    'hrsh7th/nvim-cmp',                          -- completion
    'ray-x/lsp_signature.nvim',                  -- Show function signature when you type
    'stevearc/conform.nvim',                     -- formatter
  },
  config = function()
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    local lsp_servers = { -- ensure installed language server
      "lua_ls",
      "html",
      "cssls",
      "emmet_ls",
      "gopls",
      "pyright",
      "tsserver",
      "jsonls",
      "helm_ls",
      "terraformls",
    }

    local tools = {
      "prettier", -- prettier formatter
      "autopep8", -- python formatter
    }

    local mason_tool_installer = require("mason-tool-installer")
    mason_tool_installer.setup {
      ensure_installed = tools,
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

    -- prepare lsp cmp injection
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local buf = vim.lsp.buf
    local on_attach = function(client, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      keymap.set('n', 'gt', buf.hover, bufopts)
      keymap.set('n', 'gd', buf.definition, bufopts)
      keymap.set('n', 'gD', buf.declaration, bufopts)
      keymap.set('n', 'gi', buf.implementation, bufopts)
      keymap.set('n', 'gT', buf.type_definition, bufopts)
      keymap.set('n', 'gr', buf.references, bufopts)
      keymap.set('n', '<F2>', buf.rename, bufopts)
      -- keymap.set('n', 'gf', buf.format, bufopts)
    end

    -- language server config
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup {
      ensure_installed = lsp_servers,
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end,
      },
    }

    -- language formatter
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        python = { "autopep8" },
      },
      -- format_on_save = {
      --   lsp_fallback = true,
      -- },
    })
    keymap.set('n', 'gf', function()
      conform.format({
        lsp_fallback = true,
      })
    end, opts)

    -- Show function signature when you type
    local lsp_signature = require('lsp_signature')
    lsp_signature.setup {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      hint_enable = false,
      handler_opts = {
        border = 'rounded',
      }
    }

    -- nvim lsp style
    local lsp = vim.lsp
    lsp.set_log_level('off') -- disable log or debug lsp
    lsp.handlers['textDocument/hover'] = lsp.with(
      lsp.handlers.hover, {
        border = 'rounded',
      }
    )

    -- nvim lsp diagnostics style
    local diagnostic = vim.diagnostic
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
