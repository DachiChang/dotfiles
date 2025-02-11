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

    local lsp_server_configs = { -- ensure installed language server
      clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      },
      csharp_ls = {},
      cssls = {},
      emmet_ls = { -- ul.products>li.product*3>img[src="http://placehold.it/150x150"]+h2{Product $}+p{Description of product $}+span.price{Price $}  "[]" is attribute, "{}" is content
        filetypes = { "html", "css", "templ" },
      },
      intelephense = {},
      gopls = {},
      buf_ls = {},
      helm_ls = {},
      html = {},
      jsonls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }, -- Get the language server to recognize the `vim` global
            },
          }
        }
      },
      pyright = {},
      rust_analyzer = {},
      terraformls = {},
      ts_ls = {},
      templ = {},
    }
    local lsp_servers = {}
    for lsp_server, _ in pairs(lsp_server_configs) do
      table.insert(lsp_servers, lsp_server)
    end

    local tools = {
      "prettier", -- prettier formatter
      "autopep8", -- python formatter
      "buf",      -- proto formatter
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
    local on_attach = function(_, bufnr) -- NOTE: client, bufnr
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
          local lsp_server_config = lsp_server_configs[server_name] -- get lsp server configs
          local lsp_configs = {
            capabilities = capabilities,
            on_attach = on_attach,
          }
          lsp_server_config = vim.tbl_deep_extend("force", lsp_configs, lsp_server_config) -- merge lsp server configs
          require('lspconfig')[server_name].setup(lsp_server_config)
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
        templ = { "templ" }, -- NOTE: 由於 html, templ 都具有 formating 功能，因此由 conform 來指定，避免 fallback lsp formating 會有交錯 formating 的問題
        proto = { "buf" },   -- NOTE: 由於 buf beta lsp 會過 lint 導致格式化失敗，因此由 conform 來指定，避免 lsp format 錯誤
      },
      -- format_on_save = {
      --   timeout_ms = 3000,
      --   lsp_format = "fallback",
      -- },
    }
    keymap("n", "gf", function()
      conform.format({
        timeout_ms = 3000,
        lsp_format = "fallback",
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
