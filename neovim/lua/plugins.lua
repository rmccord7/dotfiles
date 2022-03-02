local fn = vim.fn
local packer_bootstrap = false

-- Run packer compile whenever this file is written.
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

-- Broken
-- Install packer if it is not installed.
-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--
-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
-- end

return require('packer').startup(function(use)
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

  use {
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
      {'hrsh7th/cmp-vsnip'},
      {'ray-x/cmp-treesitter'},
      {'lukas-reineke/cmp-under-comparator'},
    },
    before = 'nvim-lspconfig',
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
    'neovim/nvim-lspconfig',
    config = [[require('config.lsp')]],
  }

  use {
    'tami5/lspsaga.nvim',
  }

  use {
    'nvim-lua/lsp-status.nvim',
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
    opt = true,
    'romgrk/nvim-treesitter-context',
    requires = { 'nvim-treesitter/nvim-treesitter' },
  }

  use {
    'p00f/nvim-ts-rainbow',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  use {
    opt = true,
    'luukvbaal/stabilize.nvim',
    config = function()
      require("stabilize").setup({
        nested = 'QuickFixCmdPost,DiagnosticChanged *',
      })
    end,
  }

  use {
    opt = true,
    'tpope/vim-fugitive',
  }

  use {
    'mhinz/vim-signify',
  }

  use {
    'nfvs/vim-perforce',
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

