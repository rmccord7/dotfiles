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

  -- Editor
  use {
    'famiu/feline.nvim',
    config = [[require('config.feline')]],
    requires = {'kyazdani42/nvim-web-devicons'},
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
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

  -- Colors
  use {
    'marko-cerovac/material.nvim',
    config = [[require('config.material')]],
    before = "feline.nvim",
  }

  use {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        user_default_options = {
          mode = 'virtualtext',
          names = false,
        }
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

  -- Editor
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

  -- Completion
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
        background_colour = require('material.colors').editor.bg
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
    'glepnir/lspsaga.nvim',
    config = function()
        local saga = require("lspsaga")

        saga.init_lsp_saga()
    end,
  }

  use {
    "folke/lsp-trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
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

  -- Project
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require('project_nvim').setup {
        patterns = {
          '.git',
          '.nvimrc.lua',
          '.nvimrc',
          '.p4config',
          '.p4.conf',
          'compile_commands.json'},
      }
    end
  }

  use {
    "editorconfig/editorconfig-vim",
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
      'romgrk/nvim-treesitter-context',
      'p00f/nvim-ts-rainbow',

    },
    config = [[require('config.treesitter')]],
    run = ':TSUpdate',
  }

  -- LSP
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
        ensure_installed = {
          'sumneko_lua',
          'rust_analyzer',
          'clangd',
          'pyright',
          'cmake'}
      })
    end,
  }

  use {
    'neovim/nvim-lspconfig',
    after = {'mason.nvim', 'mason-lspconfig.nvim'},
    config = [[require('config.lsp')]],
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
  }

  -- Git
  use {
    'tpope/vim-fugitive',
  }

  use {
    'sindrets/diffview.nvim',
    config = function()
      require('diffview').setup()
    end
  }

  -- Version Control
  use {
    'mhinz/vim-signify',
    opt = true,
  }

  use {
    'nfvs/vim-perforce',
  }

  -- Neovim delveopment
  use {
    'folke/neodev.nvim',
  }

  -- Experimental
  use({
    "folke/noice.nvim",
    disable = true,
    config = function()
      require('noice').setup()
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      }
  })

  use {
    'MunifTanjim/exrc.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('exrc').setup({
        files = {
          '.nvimrc.lua',
          '.nvimrc'
        }
      })
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

