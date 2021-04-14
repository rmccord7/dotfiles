--Run packer compile whenever this file is written.
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- IDE stuff
  use {
    'hoob3rt/lualine.nvim',
    config = [[require('config.lualine')]],
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  use {
    'romgrk/barbar.nvim',
    config = [[require('config.barbar')]],
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = [[require('config.tree')]],
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  use {
    'Yggdroot/indentLine',
  }

  use {
    'airblade/vim-rooter',
    config = [[require('config.rooter')]],
  }

  -- tpope
  use {
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
    'tomtom/tcomment_vim',
  }

  -- Misc
  use {
    'junegunn/vim-easy-align',
    config = [[require('config.easy-align')]],
  }

  use {
    'phaazon/hop.nvim',
    config = [[require('config.hop')]],
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim'}
    }
  }

  use {
    'hrsh7th/nvim-compe',
    config = [[require('config.compe')]],
    requires = {
      {
        'hrsh7th/vim-vsnip',
        config = [[require('config.vsnip')]]
      },
    }
  }

  --LSP
  use {
    'neovim/nvim-lspconfig',
    config = [[require('config.lsp')]],
    requires = {'onsails/lspkind-nvim'}
  }

  use {
    'nvim-lua/lsp-status.nvim',
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = [[require('config.treesitter')]],
    requires = {
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',
    'romgrk/nvim-treesitter-context',
    'p00f/nvim-ts-rainbow'
    },
    run = ':TSUpdate'
  }

  -- build support
  use {
    'ilyachur/cmake4vim',
    config = [[require('config.cmake')]]
  }

  -- git and version control
  use {
    'tpope/vim-fugitive',
  }

  use {
    'mhinz/vim-signify',
    opt = true
  }

  use {
    'nfvs/vim-perforce',
  }
end)
