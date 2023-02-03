local lsp = vim.lsp

-- diagnostics color
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = 234 })
vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = 234 })

lsp.handlers['textDocument/hover'] = lsp.with(
  lsp.handlers.hover, {
  border = 'rounded',
})
