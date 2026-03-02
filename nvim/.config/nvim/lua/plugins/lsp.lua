return {
  'mason-org/mason.nvim', -- mason lsp and tools manager
  enabled = true,
  dependencies = {
    'mason-org/mason-lspconfig.nvim', -- bridge between mason package name and nvim-lspconfig required by mason-tool-installer
    'neovim/nvim-lspconfig',          -- language server default config
  },
  config = function()
    local keymap = vim.keymap.set

    -- Language Server configmap
    local lsp_server_configs = {
      -- NOTE: common
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
      -- NOTE: web
      html = {},
      cssls = {},
      emmet_ls = { -- ul.products>li.product*3>img[src="http://placehold.it/150x150"]+h2{Product $}+p{Description of product $}+span.price{Price $}  "[]" is attribute, "{}" is content
        filetypes = { "html", "css", "templ" },
      },
      tailwindcss = {},
      ts_ls = {},
      -- NOTE: go
      gopls = {},
      buf_ls = {},
      templ = {
        cmd = { 'go', 'tool', 'templ', 'lsp' }, -- go 1.24 support tool dependencies
      },
      -- NOTE: python
      pyright = {},
      -- NOTE: devops
      helm_ls = {},
      terraformls = {},
      lemminx = {}, -- xml lsp
      -- clangd = {},
      -- csharp_ls = {},
      -- intelephense = {},
      -- rust_analyzer = {},
    }

    -- Mason UI config
    local mason_installer = require('mason')
    mason_installer.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    -- Mason install language servers
    local ensured_installed_lsp = {}
    for lsp_server, _ in pairs(lsp_server_configs) do -- parse key, table
      table.insert(ensured_installed_lsp, lsp_server) -- collect server to ensured_installed_lsp_servers
    end
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup({
      ensure_installed = ensured_installed_lsp,
      automatic_enable = false, -- enable by loop config language server below
    })

    -- global language server config
    local lsp = vim.lsp
    lsp.log.set_level(vim.log.levels.OFF) -- log levels ex: DEBUG | ERROR | INFO | TRACE | WARN | OFF
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
        local bufopts = { buffer = event.buf }
        keymap("n", "gt", function() buf.hover { border = 'rounded' } end, bufopts)
        keymap("n", "gD", buf.declaration, bufopts)
        keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", bufopts) -- 用 Telescope command 讓 plugins 之間解偶合
        keymap("n", "gi", "<CMD>Telescope lsp_implementations<CR>", bufopts)
        keymap("n", "gT", "<CMD>Telescope lsp_type_definitions<CR>", bufopts)
        keymap("n", "gr", "<CMD>Telescope lsp_references<CR>", bufopts)
        keymap("n", "<LEADER>s", "<CMD>Telescope lsp_document_symbols symbol_width=50<CR>", bufopts)
        keymap("n", "gn", buf.rename, bufopts)
        keymap("n", "ga", buf.code_action, bufopts)
      end,
    })
  end,
}
