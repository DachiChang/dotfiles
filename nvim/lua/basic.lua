local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

-- Theme
cmd "colorscheme molokai"

-- option basic
opt.swapfile = false
opt.backspace = "2"
opt.mouse = "n"
opt.clipboard = "unnamed"

-- option fold
opt.foldenable = false
opt.foldmethod = "syntax"

-- option search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true

-- option programming
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.showmatch = true

-- option tab
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true

-- split position
opt.splitright = true
opt.splitbelow = true

-- end of buffer filled line char
opt.fillchars:append { eob = " " }

-- option
opt.cursorline = true
api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 220, cterm = none })
