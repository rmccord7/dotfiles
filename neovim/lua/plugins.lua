local fn = vim.fn
local packer_bootstrap = false

-- Run packer compile whenever this file is written.
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

-- Install packer if it is not installed.
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

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
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = [[require('config.tree')]],
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
  }

  use {
    'simrat39/symbols-outline.nvim',
    config = [[require('config.symbols-outline')]],
  }

  use {
    'airblade/vim-rooter',
    config = [[require('config.rooter')]],
  }

  use {
    'b3nj5m1n/kommentary',
    config = [[require('config.kommentary')]],
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
    'skywind3000/gutentags_plus',
    opt = true,
    requires = {'ludovicchabant/vim-gutentags'},
    config = [[require('config.gutentags')]]
  }

  use {
    "lazytanuki/nvim-mapper",
    config = function() require("nvim-mapper").setup{} end,
    before = "telescope.nvim"
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
    --commit = '9ada17bb847a83f8356934a314a793bfe3c9a712',
    before = "feline.nvim"
  }

  use {
    'norcalli/nvim-colorizer.lua',
  }

  -- Misc
  use {
    'junegunn/vim-easy-align',
    config = [[require('config.easy-align')]],
  }

  use {
    'ggandor/lightspeed.nvim',
    config = [[require('config.lightspeed')]],
  }

  use {
    'rmagatti/auto-session',
    config = [[require('config.auto-session')]],
  }

  use {
    'rmagatti/session-lens',
    requires = {
      {'rmagatti/auto-session'},
    },
    config = function()
      require('session-lens').setup({})
    end
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim'}
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
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-nvim-lua'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'quangnguyen30192/cmp-nvim-tags'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-vsnip'},
      {'ray-x/cmp-treesitter'},
    },
    before = 'nvim-lspconfig',
  }

  --LSP
  use {
    'neovim/nvim-lspconfig',
    config = [[require('config.lsp')]],
    requires = {'onsails/lspkind-nvim'}
  }

  use {
    --'glepnir/lspsaga.nvim',
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
    config = function() require("stabilize").setup() end
  }

  -- build support
  use {
    'ilyachur/cmake4vim',
    config = [[require('config.cmake')]]
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
