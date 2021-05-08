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
    branch = 'lua'
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

  -- colors
  use {
    'rmccord7/material.nvim',
    config = [[require('config.material')]]
  }

  use {
    'norcalli/nvim-colorizer.lua',
  }

  -- tpope
  use {
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-unimpaired',
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
  use {'pwntester/octo.nvim', config=function()
    require"octo".setup({
      date_format = "%Y %b %d %I:%M %p %Z";   -- Date format
      remote_order = {"upstream", "origin"};  -- Order to resolve the remote for the current working directory
      qf_height = 11;                         -- Percent (when 0 < value < 1) or absolute (when value > 1) height of quickfix window
      user_icon = " ";                       -- Icon used to signal user names
      reaction_viewer_hint_icon = "";        -- Icon as alternative or to complement the highlighting of reactions by the viewer himself
      left_bubble_delimiter = "";            -- Left (unicode) character to draw a bubble for labels etc.
      right_bubble_delimiter = "";           -- Right (unicode) character to draw a bubble for labels etc.
      github_hostname = "";                   -- Host name to use for non-public GHE (GitHub Enterprise) instances
      snippet_context_lines = 4;              -- Number of additional lines displayed from the diff-hunk for single-line comments
      mappings = {
        reload = "<C-r>";                     -- reload issue/PR
        open_in_browser = "<C-o>";            -- open issue/PR in browser
        goto_issue = "<space>gi";             -- navigate to a local repo issue
        close = "<space>ic";                  -- close issue/PR
        reopen = "<space>io";                 -- reopen issue/PR
        list_issues = "<space>il";            -- list open issues on same repo
        list_commits = "<space>pc";           -- list PR commits
        list_changed_files = "<space>pf";     -- list PR changed files
        show_pr_diff = "<space>pd";           -- show PR diff
        checkout_pr = "<space>po";            -- checkout PR
        merge_pr = "<space>pm";               -- merge PR
        add_reviewer = "<space>va";           -- add reviewer
        remove_reviewer = "<space>vd";        -- remove reviewer
        add_assignee = "<space>aa";           -- add assignee
        remove_assignee = "<space>ad";        -- remove assignee
        add_label = "<space>la";              -- add label
        remove_label = "<space>ld";           -- remove label
        add_comment = "<space>ca";            -- add comment
        delete_comment = "<space>cd";         -- delete comment
        add_suggestion = "<space>sa";         -- add review suggestion
        react_hooray = "<space>rp";           -- add/remove 🎉 reaction
        react_heart = "<space>rh";            -- add/remove ❤️ reaction
        react_eyes = "<space>re";             -- add/remove 👀 reaction
        react_thumbs_up = "<space>r+";        -- add/remove 👍 reaction
        react_thumbs_down = "<space>r-";      -- add/remove 👎 reaction
        react_rocket = "<space>rr";           -- add/remove 🚀 reaction
        react_laugh = "<space>rl";            -- add/remove 😄 reaction
        react_confused = "<space>rc";         -- add/remove 😕 reaction
        next_changed_file = "]q";             -- go to next file
        prev_change_file = "[q";              -- go to previous file
        next_comment = "]c";                  -- go to next change
        prev_comment = "[c";                  -- go to previous change
        next_thread = "]t";                   -- go to previous comment thread
        prev_thread = "[t";                   -- go to next comment thread
        close_tab = "<C-c>";                  -- close review tab
      }
    })
  end}

  use {
    'tpope/vim-fugitive',
  }

  use {
    'mhinz/vim-signify',
  }

  use {
    'nfvs/vim-perforce',
  }
end)
