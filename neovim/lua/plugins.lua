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

  -- Completion and linting
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

  --BarBar
  use {
    'romgrk/barbar.nvim',
    config = [[require('config.barbar')]],
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  --BarBar
  use {
    'kyazdani42/nvim-tree.lua',
    config = [[require('config.tree')]],
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  --Lualine
  use {
    'hoob3rt/lualine.nvim',
    config = [[require('config.lualine')]],
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  --Compe
  use {
    'hrsh7th/nvim-compe',
    config = [[require('config.compe')]]
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

  --Telecope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzy-native.nvim'}}
  }

  use {
    'hrsh7th/vim-vsnip',
    requires = {{'rafamadriz/friendly-snippets'}}
  }

  use {
    'mhinz/vim-signify',
  }

  use {
    'junegunn/vim-easy-align',
    config = [[require('config.easy-align')]],
  }

  use {
    'phaazon/hop.nvim',
    config = [[require('config.hop')]],
  }

  use {
    'airblade/vim-rooter',
    config = [[require('config.rooter')]],
  }

  use {
    'ilyachur/cmake4vim',
    config = [[require('config.cmake')]]
  }

  use {
    'nfvs/vim-perforce',
  }

  use {
    'nathanaelkane/vim-indent-guides',
  }

  use {
    'Yggdroot/indentLine',
  }

  use {
    'tpope/vim-fugitive',
  }

  use {
    'tpope/vim-surround',
  }

  use {
    'tpope/vim-repeat',
  }

  use {
    'tpope/vim-unimpaired',
  }

  use {
    'tomtom/tcomment_vim',
  }

end)
