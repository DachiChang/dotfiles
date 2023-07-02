local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- regex in search/replace for folder
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  -- yaml folds
  'pedrohdz/vim-yaml-folds',
  -- helm syntax
  'towolf/vim-helm',
  -- indent block
  'lukas-reineke/indent-blankline.nvim',
  -- keyword highlight and jump to reference
  'RRethy/vim-illuminate',
  -- editorconfig
  'gpanders/editorconfig.nvim',
  -- detecting whitespace
  'ntpeters/vim-better-whitespace',
  -- lualine
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
  -- luatab
  {
    'dachichang/luatab.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },
  -- bufferline
  -- {
  --   'akinsho/bufferline.nvim',
  --   version = "v3.*",
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  -- },
  -- nvim-tree
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },
  -- quick moving in screen
  {
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat',
    },
  },
  -- telescope, a fuzzy finder
  -- REQUIRED: brew install ripgrep
  {
    'nvim-telescope/telescope.nvim',
    -- version = '0.1.1',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  -- telescope tabs fly
  {
    'LukasPietzschmann/telescope-tabs',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  -- tagbar, overview of file structure
  -- REQUIRED: brew install universal-ctags, gotags
  'preservim/tagbar',
  -- emmet-vim
  'mattn/emmet-vim', -- ctrl-y + , (trigger)
  -- autopep8
  {
    'tell-k/vim-autopep8',
    ft = 'python',
  },
  -- terraformls
  'hashivim/vim-terraform',
  -- toggleterm
  'akinsho/toggleterm.nvim', -- ctrl + \ (trigger)
  -- lsp
  {
    'neovim/nvim-lspconfig',               -- language server protocal client
    dependencies = {
      'williamboman/mason.nvim',           -- language server installer
      'williamboman/mason-lspconfig.nvim', -- bridge between client and mason
      'ray-x/lsp_signature.nvim',          -- Show function signature when you type
    },
  },
  -- nvim-cmp
  {
    'hrsh7th/nvim-cmp',               -- completion
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',         -- bridge lspconfig
      'hrsh7th/cmp-buffer',           -- source from buffer
      'hrsh7th/cmp-path',             -- source from path
      'hrsh7th/cmp-cmdline',          -- source from cmd line
      'L3MON4D3/LuaSnip',             -- snippet engine
      'saadparwaiz1/cmp_luasnip',     -- bridge LuaSnip
      'dmitmel/cmp-cmdline-history',  -- source cmdline history
      'rafamadriz/friendly-snippets', -- source snippets
    },
  },
}

local opts = {
  ui = {
    border = "rounded",
  },
}

require("lazy").setup(plugins, opts)
