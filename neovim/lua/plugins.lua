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
  max_jobs = 8,
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

  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end
  })

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
    before = "feline.nvim",
    commit = 'de33236'
  }

  use {
    opt = true,
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {}
    end
  }

  use {
    "klen/nvim-config-local",
    config = function()
      require('config-local').setup {
        config_files = { '.nvimrc.lua' },
      }
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

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim'},
      {'nvim-telescope/telescope-file-browser.nvim'},
      {'LinArcX/telescope-env.nvim'},
      {'Badhi/vim-p4-files'},
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
    opt = true,
    config = function()
      require("which-key").setup {
        plugins = {
          presets = {
            operators = false,
            textobjects = false,
            motions = false,
          }
        }
      }
    end
  }

  use {
    'sindrets/diffview.nvim',
    config = function()
      require('diffview').setup()
    end
  }

  --LSP
  use {
    'neovim/nvim-lspconfig',
    after = {'mason.nvim', 'mason-lspconfig.nvim'},
    config = [[require('config.lsp')]],
  }

  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        log_level = vim.log.levels.DEBUG,
      })
    end,
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    after = {'mason.nvim'},
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {'sumneko_lua', 'rust_analyzer', 'clangd', 'pyright', 'cmake'}
      })
    end,
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

  use {
    'folke/neodev.nvim',
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
    'tpope/vim-fugitive',
  }

  use {
    'mhinz/vim-signify',
    opt = true,
  }

  use {
    'nfvs/vim-perforce',
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

