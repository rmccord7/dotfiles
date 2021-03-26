local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
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
  use {'romgrk/barbar.nvim', 
    config = [[require('config.barbar')]],
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
    config = [[require('config.compe')]], 
    event = 'InsertEnter *'
  } 

  --LSP
  use {
    'neovim/nvim-lspconfig',
    config = [[require('config.lsp')]]
  }

  --Telecope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  --View Registers
  use {
    'gennaro-tedesco/nvim-peekup',
    config = [[require('config.peekup')]]
  }

end)
