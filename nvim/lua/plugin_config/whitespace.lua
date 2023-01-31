require('whitespace-nvim').setup()
-- Keymap normal mode, \ + t
vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)
