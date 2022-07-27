local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
end

vim.cmd [[packadd packer.nvim]]

local ok, packer = pcall(require, "packer")

if not ok then
    return
end

packer.init {
  display = {
      open_fn = function()
          return require("packer.util").float { border = "single" }
      end,
      prompt_border = "single",
  },
  git = {

      clone_timeout = 600,
  },
  auto_clean = true,
  compile_on_sync = true,
}

-- Run packer compile whenever this file is written.
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- IDE stuff
  use {
    'famiu/feline.nvim',
    config = [[require('config.feline')]],
    requires = {'kyazdani42/nvim-web-devicons'},
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
  }

  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require('project_nvim').setup {
        patterns = {'.git', '.p4config', '.p4.conf', 'compile_commands.json'},
      }
    end
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
  }

  use {
    "editorconfig/editorconfig-vim",
  }

  use {
    'bfredl/nvim-miniyank',
  }

  use {
    'ray-x/lsp_signature.nvim',
  }

  use {
    'machakann/vim-sandwich',
  }

  use {
    'ludovicchabant/vim-gutentags',
    config = [[require('config.gutentags')]]
  }

  use {
    "AckslD/nvim-neoclip.lua",
    config = function()
        require('neoclip').setup()
    end,
  }

  use {
    'tpope/vim-abolish',
  }

  use {
    'rmccord7/ss1pwn',
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require ('config.autopairs')
    end
  }

  use {
    'toppair/reach.nvim',
    config = function()
      require('reach').setup {}
    end
  }

  -- colors
  use {
    'marko-cerovac/material.nvim',
    config = [[require('config.material')]],
    before = "feline.nvim"
  }

  use {
    opt = true,
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {}
    end
  }

  -- Misc
  use {
    'junegunn/vim-easy-align',
    config = [[require('config.easy-align')]],
  }

  use{
    'ggandor/lightspeed.nvim',
    config = function()
      require('lightspeed').setup {
      }
      vim.cmd('doautocmd User LightspeedEnter nohlsearch')
      vim.cmd('doautocmd User LightspeedEnter TSBufDisable rainbow')
      vim.cmd('doautocmd User LightspeedLeave TSBufEnable rainbow')
    end
  }

  use {
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup {
    }
  end
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim'},
      {'nvim-telescope/telescope-file-browser.nvim'}
    },
    config = [[require('config.telescope')]],
  }

  use {
    'hrsh7th/nvim-cmp',
    config = [[require('config.cmp')]],
    requires = {
      {
        'hrsh7th/vim-vsnip',
        config = [[require('config.vsnip')]]
      },
      {'onsails/lspkind-nvim'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-nvim-lua', ft = 'lua'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'quangnguyen30192/cmp-nvim-tags'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'ray-x/cmp-treesitter'},
      {'lukas-reineke/cmp-under-comparator'},
    },
    before = 'nvim-lspconfig',
  }

  use {
    "L3MON4D3/LuaSnip",
    config = [[require('snippets')]],
  }

  --Harpoon
  use {
    'ThePrimeagen/harpoon',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope.nvim'},
    },
    config = function()
      require('harpoon').setup({})
    end
  }

  use {
    opt = true,
    'VonHeikemen/fine-cmdline.nvim',
    config = function()
      require('fine-cmdline').setup({
        popup = {
          position = {
            row = '50%',
            col = '50%',
          },
        },
      })
    end,
    requires = {
      {'MunifTanjim/nui.nvim'}
    }
  }

  use {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup({
        stages = "fade",
        background_colour = require('material.colors').bg
      })

      vim.notify = require 'notify'
    end,
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require("which-key").setup {
      }
    end
  }

  --LSP
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    requires = { 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {'sumneko_lua', 'rust_analyzer', 'clangd', 'pyright', 'cmake-language-server'}
      })
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    config = [[require('config.lsp')]],
  }

  use {
    'glepnir/lspsaga.nvim',
    config = function()
        local saga = require("lspsaga")

        saga.init_lsp_saga({
            -- your configuration
        })
    end,
  }

  use {
    "folke/lsp-trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = [[require('config.treesitter')]],
    run = ':TSUpdate'
  }

  use {
    'nvim-treesitter/nvim-treesitter-refactor',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  use {
    opt = true,
    'nvim-treesitter/playground',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  use {
    'romgrk/nvim-treesitter-context',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  }

  use {
    'p00f/nvim-ts-rainbow',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  use {
    'luukvbaal/stabilize.nvim',
    config = function()
      require("stabilize").setup({
        nested = 'QuickFixCmdPost,DiagnosticChanged *',
      })
    end,
  }

  use {
    'tpope/vim-fugitive',
  }

  use {
    'mhinz/vim-signify',
  }

  use {
    'nfvs/vim-perforce',
  }

  use {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  config = function()
    require("lsp_lines").setup()
  end,
  }

  use {
  'kyazdani42/nvim-tree.lua',
  requires = {
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
    require("nvim-tree").setup()
  end,
  tag = 'nightly'
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

