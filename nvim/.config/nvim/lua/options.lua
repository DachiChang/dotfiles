local opt = vim.opt

-- NOTE: option scope
-- vim.opt          global-only, buffer global/local, window global/local options
-- vim.opt_global   global-only, buffer global, window global
-- vim.opt_local                 buffer local, window local
-- vim.b            buffer local variable
-- vim.bo           buffer local options (ex: shiftwidth)
-- vim.w            window local variable
-- vim.wo           window local options (ex: foldmethod)
-- vim.g            global variable
-- vim.go           global-only options (ex: encoding)

-- option basic
opt.swapfile = false
opt.backspace = "2"
opt.mouse = "n"
opt.clipboard = "unnamed"
opt.termguicolors = true

-- option search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
-- opt.wrapscan = false

-- option programming
opt.number = true
opt.relativenumber = false
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

-- option highlight cursorline
opt.cursorline = true

-- opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
