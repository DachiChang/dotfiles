return {
  'mason-org/mason.nvim', -- mason lsp and tools manager
  enabled = true,
  dependencies = {
    'mason-org/mason-lspconfig.nvim', -- bridge between mason package name and nvim-lspconfig required by mason-tool-installer
    'neovim/nvim-lspconfig',          -- language server default config
  },
  config = function()
    local keymap = vim.keymap.set
    local default_opts = { noremap = true, silent = true }

    -- Language Server configmap
    local lsp_server_configs = {
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
      tailwindcss = {
        root_markers = { 'tailwind.css' },
      },
    }

    -- Mason UI config
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

    -- Mason install language servers
    local ensured_installed_lsp = {}
    for lsp_server, _ in pairs(lsp_server_configs) do -- parse key, table
      table.insert(ensured_installed_lsp, lsp_server) -- collect server to ensured_installed_lsp_servers
    end
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup {
      ensure_installed = ensured_installed_lsp,
      automatic_enable = false, -- enable by loop config language server below
    }

    -- global language server config
    local lsp = vim.lsp
    lsp.set_log_level('off') -- disable log or debug lsp
    -- For each language server config and enable
    for server, config in pairs(lsp_server_configs) do
      lsp.config(server, config)
      lsp.enable(server)
    end
    -- global language server attach event
    local lsp_attach_group = vim.api.nvim_create_augroup("NvimLspAttach", { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', {
      group = lsp_attach_group,
      callback = function(event)
        local buf = vim.lsp.buf
        local bufopts = { noremap = true, silent = true, buffer = event.buf }
        keymap("n", "gt", function() buf.hover { border = 'rounded' } end, bufopts)
        keymap("n", "gD", buf.declaration, bufopts)
        keymap("n", "gd", ":Telescope lsp_definitions<CR>", bufopts)
        keymap("n", "gi", ":Telescope lsp_implementations<CR>", bufopts)
        keymap("n", "gT", ":Telescope lsp_type_definitions<CR>", bufopts)
        keymap("n", "gr", ":Telescope lsp_references<CR>", bufopts)
        keymap("n", "gn", buf.rename, bufopts)
        keymap("n", "ga", buf.code_action, bufopts)
      end,
    })

    -- Diagnostics config
    local diagnostic = vim.diagnostic
    diagnostic.config {
      virtual_lines = {
        current_line = true,
      },
      -- virtual_text = {
      --   current_line = true,
      -- },
      float = {
        border = 'rounded',
      }
    }
    keymap("n", "ge", diagnostic.open_float, default_opts)
    keymap("n", "ep", diagnostic.goto_prev, default_opts)
    keymap("n", "en", diagnostic.goto_next, default_opts)
  end,
}
