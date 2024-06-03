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
    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }

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
      "rust_analyzer",
      "clangd",
      "csharp_ls",
    }

    local tools = {
      "prettier", -- prettier formatter
      "autopep8", -- python formatter
    }

    local mason_tool_installer = require('mason-tool-installer')
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
      keymap("n", "gt", buf.hover, bufopts)
      keymap("n", "gD", buf.declaration, bufopts)
      keymap("n", "gd", ":Telescope lsp_definitions<CR>", bufopts)
      keymap("n", "gi", ":Telescope lsp_implementations<CR>", bufopts)
      keymap("n", "gT", ":Telescope lsp_type_definitions<CR>", bufopts)
      keymap("n", "gr", ":Telescope lsp_references<CR>", bufopts)
      keymap("n", "<F2>", buf.rename, bufopts)
      -- keymap.set("n", "gf", buf.format, bufopts)
    end

    -- language server config
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup {
      ensure_installed = lsp_servers,
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end,
      },
    }

    -- language formatter
    local conform = require('conform')
    conform.setup {
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
    }
    keymap("n", "gf", function()
      conform.format({
        timeout_ms = 3000,
        lsp_fallback = true,
      })
    end, default_opts)

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
    keymap("n", "ge", diagnostic.open_float, default_opts)
    keymap("n", "ep", diagnostic.goto_prev, default_opts)
    keymap("n", "en", diagnostic.goto_next, default_opts)
  end,
}
