local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0,
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    -- packer
    use {
      'wbthomason/packer.nvim',
    }

    -- editorconfig
    use {
      'gpanders/editorconfig.nvim',
    }

    -- detecting whitespace
    use {
      'ntpeters/vim-better-whitespace',
    }

    -- lualine
    use {
      'nvim-lualine/lualine.nvim',
      requires = {
        'nvim-tree/nvim-web-devicons',
      }
    }

    -- tabulous
    use {
      'webdevel/tabulous',
    }

    -- nvim-tree
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons',
      }
    }

    -- telescope, a fuzzy finder
    -- REQUIRED: brew install ripgre
    use {
      {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
          'nvim-lua/plenary.nvim',
        }
      },
      'LukasPietzschmann/telescope-tabs',
    }

    -- tagbar, overview of file structure
    -- REQUIRED: brew install universal-ctags, gotags
    use {
      'preservim/tagbar',
    }

    -- emmet-vim
    use {
      'mattn/emmet-vim', -- ctrl-y + , (trigger)
    }

    -- autopep8
    use {
      'tell-k/vim-autopep8',
    }

    -- terraformls
    use {
      'hashivim/vim-terraform',
    }

    -- toggleterm
    use {
      'akinsho/toggleterm.nvim', -- ctrl + \ (trigger)
    }

    -- lsp
    use {
      'neovim/nvim-lspconfig', -- language server protocal client
      'williamboman/mason.nvim', -- language server installer
      'williamboman/mason-lspconfig.nvim', -- bridge between client and mason
    }

    -- nvim-cmp
    use {
      'hrsh7th/nvim-cmp', -- completion
      'hrsh7th/cmp-nvim-lsp', -- bridge lspconfig
      'hrsh7th/cmp-buffer', -- source from buffer
      'hrsh7th/cmp-path', -- source from path
      'hrsh7th/cmp-cmdline', -- source from cmd line
      'L3MON4D3/LuaSnip', -- snippet engine
      'saadparwaiz1/cmp_luasnip', -- bridge LuaSnip
      'dmitmel/cmp-cmdline-history', -- source cmdline history
      'rafamadriz/friendly-snippets', -- source snippets
    }

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
