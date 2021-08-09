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
    'lukas-reineke/indent-blankline.nvim',
  }

  use {
    'simrat39/symbols-outline.nvim',
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
    'folke/which-key.nvim',
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
    'rmccord7/ss1pwn',
  }

  -- colors
  use {
    'marko-cerovac/material.nvim',
    config = [[require('config.material')]]
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
    'phaazon/hop.nvim',
    config = [[require('config.hop')]],
    opt = true
  }

  use {
    'ggandor/lightspeed.nvim',
  }

  use {
    'rmagatti/session-lens',
    requires = {
      {'rmagatti/auto-session'},
    },
    config = function()
      require('session-lens').setup({--[[your custom config--]]})
    end
  }

  use {
    'folke/twilight.nvim',
    config = function()
      require("twilight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
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
    'glepnir/lspsaga.nvim',
  }

  use {
    'nvim-lua/lsp-status.nvim',
  }

  use {
  "folke/lsp-trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {
      {
        height = 10, -- height of the trouble list
        icons = true, -- use devicons for filenames
        mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        action_keys = { -- key mappings for actions in the trouble list
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
            jump_close = {"o"}, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small poup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = {"zM", "zm"}, -- close all folds
            open_folds = {"zR", "zr"}, -- open all folds
            toggle_fold = {"zA", "za"}, -- toggle fold of current file
            previous = "k", -- preview item
            next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        signs = {
            -- icons / text used for a diagnostic
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠"
        },
        use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
      }
    }
  end
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
end, {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
})
