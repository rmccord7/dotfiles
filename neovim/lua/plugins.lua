global = require('global')

return {
    -- Editor
    {
        'famiu/feline.nvim',
        event = 'VeryLazy',
        config = function()
            require('config.feline')
        end,
        dependencies = { 'kyazdani42/nvim-web-devicons' },
    },

    {
        'lukas-reineke/indent-blankline.nvim',
    },

    {
        'bfredl/nvim-miniyank',
    },

    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup({})
        end,
    },

    {
        'ludovicchabant/vim-gutentags',
        config = function()
            require('config.gutentags')
        end,
    },

    {
        'AckslD/nvim-neoclip.lua',
        config = function()
            require('neoclip').setup()
        end,
    },

    {
        'tpope/vim-abolish',
    },

    {
        'rmccord7/ss1pwn',
    },

    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end,
    },

    {
        'toppair/reach.nvim',
        config = function()
            require('reach').setup({})
        end,
    },

    -- Colors
    {
        'marko-cerovac/material.nvim',
        lazy = false,
        config = function()
            require('config.material')
        end,
        priority = 1000,
    },

    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                user_default_options = {
                    mode = 'virtualtext',
                    names = false,
                },
            })
        end,
    },

    -- Misc
    {
        'junegunn/vim-easy-align',
        config = function()
            require('config.easy-align')
        end,
    },

    {
        'ggandor/lightspeed.nvim',
        config = function()
            require('lightspeed').setup({})
            vim.cmd('doautocmd User LightspeedEnter nohlsearch')
            vim.cmd('doautocmd User LightspeedEnter TSBufDisable rainbow')
            vim.cmd('doautocmd User LightspeedLeave TSBufEnable rainbow')
        end,
    },

    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup({})
        end,
    },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    },

    -- Editor
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'LinArcX/telescope-env.nvim',
            'Badhi/vim-p4-files',
        },
        config = function()
            require('config.telescope')
        end,
    },

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            require('config.cmp')
        end,
        dependencies = {
            'hrsh7th/vim-vsnip',
            'onsails/lspkind-nvim',
            'hrsh7th/cmp-buffer',
            'amarakon/nvim-cmp-buffer-lines',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'quangnguyen30192/cmp-nvim-tags',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'ray-x/cmp-treesitter',
            'lukas-reineke/cmp-under-comparator',
        },
    },

    {
        'hrsh7th/vim-vsnip',
        config = function()
            require('config.vsnip')
        end,
    },

    {
        'L3MON4D3/LuaSnip',
        config = function()
            require('snippets')
        end,
    },

    {
        'rcarriga/nvim-notify',
        --before = 'reach.nvim',
        event = 'VeryLazy',
        config = function()
            nvim_notify = require('notify').setup({
                level = vim.log.levels.TRACE,
                timeout = 3000,
                stages = 'fade',
                background_colour = require('material.colors').editor.bg,
            })

            vim.notify = function(msg, log_level, opts)
                log_level = log_level or vim.log.levels.DEBUG

                -- Auto-convert tables to string interpretation so we can print it
                if type(msg) == 'table' then
                    msg = vim.inspect(msg)
                elseif not msg then
                    msg = 'CUSTOM NOTIFY FAILED'
                    log_level = vim.log.level.DEBUG
                    opts = {}
                end
                require('notify')(msg, log_level, opts)
            end

            -- Notify
            nmap('<leader>nc', function()
                nvim_notify.dismiss({ pending = true })
            end, 'Notification Clear')
        end,
    },

    {
        enabled = false,
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup({
                plugins = {
                    marks = false,
                    registers = false,
                    presets = {
                        operators = false,
                        text_objects = false,
                        motions = false,
                        windows = false,
                        nav = false,
                        z = false,
                        g = false,
                    },
                },
                triggers_blacklist = {
                    n = {
                        'y',
                        'd',
                    },
                },
            })
        end,
    },

    {
        'glepnir/lspsaga.nvim',
        branch = 'main',
        config = function()
            require('lspsaga').setup({})
        end,
    },

    {
        'folke/lsp-trouble.nvim',
        dependencies = 'kyazdani42/nvim-web-devicons',
    },

    {
        'kyazdani42/nvim-tree.lua',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup()
        end,
        version = 'nightly',
    },

    -- Formatting lua files.
    {
        'ckipp01/stylua-nvim',
    },

    -- Project
    {
        'ahmedkhalf/project.nvim',
        config = function()
            require('project_nvim').setup({
                patterns = {
                    '.git',
                    '.nvimrc.lua',
                    '.nvimrc',
                    '.p4config',
                    '.p4.conf',
                    'compile_commands.json',
                },
            })
        end,
    },

    {
        'editorconfig/editorconfig-vim',
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
            'romgrk/nvim-treesitter-context',
            'p00f/nvim-ts-rainbow',
        },
        config = function()
            require('config.treesitter')
        end,
        build = ':TSUpdate',
    },

    -- LSP
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                providers = {
                    'mason.providers.client',
                    'mason.providers.registry-api',
                },
                log_level = vim.log.levels.DEBUG,
            })
        end,
    },

    {
        'williamboman/mason-lspconfig.nvim',
        -- after = { 'mason.nvim' },
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'sumneko_lua',
                    'rust_analyzer',
                    'clangd',
                    'pyright',
                    'cmake',
                },
            })
        end,
    },

    {
        'neovim/nvim-lspconfig',
        -- after = { 'mason.nvim', 'mason-lspconfig.nvim' },
        config = function()
            require('config.lsp')
        end,
    },

    -- Git
    {
        'tpope/vim-fugitive',
    },

    {
        'sindrets/diffview.nvim',
        config = function()
            require('diffview').setup()
        end,
    },

    -- Version Control
    {
        'mhinz/vim-signify',
        enabled = false,
    },

    {
        'nfvs/vim-perforce',
    },

    -- Neovim delveopment
    {
        'folke/neodev.nvim',
    },

    -- References
    {
        'nanotee/nvim-lua-guide',
    },

    {
        'milisims/nvim-luaref',
    },

    -- Experimental
    {
        'folke/noice.nvim',
        enabled = false,
        config = function()
            require('noice').setup()
        end,
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },

    -- Fun
    {
        'Eandrju/cellular-automaton.nvim',
    },
}
