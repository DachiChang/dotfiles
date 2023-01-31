local lsp = vim.lsp

lsp.handlers['textDocument/hover'] = lsp.with(
  lsp.handlers.hover, {
  border = 'rounded'
})
