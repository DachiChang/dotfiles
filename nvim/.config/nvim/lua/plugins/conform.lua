return {
  'stevearc/conform.nvim',
  enabled = true,
  config = function()
    local keymap = vim.keymap.set

    -- NOTE: 定義的 formatter 有最高優先權，若該 filetype 沒有指定那就看起來的 lsp server 有沒有支援 format
    local conform = require('conform')
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" }, -- WARN: Mason install
        typescript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        python = { "autopep8" }, -- WARN: Mason install
        templ = { "templ" },     -- NOTE: 由於 html, templ 都具有 formating 功能，因此由 conform 來指定，避免 fallback lsp formating 會有交錯 formating 的問題
        proto = { "buf" },       -- NOTE: 由於 buf beta lsp 會過 lint 導致格式化失敗，因此由 conform 來指定，避免 lsp format 錯誤
      },
      -- format_on_save = {
      --   timeout_ms = 3000,
      --   lsp_format = "fallback",
      -- },
    })
    keymap("n", "gf", function()
      conform.format({
        timeout_ms = 3000,
        lsp_format = "fallback",
      })
    end)
  end
}
