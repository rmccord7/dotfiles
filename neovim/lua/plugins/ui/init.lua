local M = {

    require('plugins.ui.treesitter'),
    require('plugins.ui.feline'),
    require('plugins.ui.material'),
    require('plugins.ui.tree'),
    require('plugins.ui.trouble'),

    {
        'lukas-reineke/indent-blankline.nvim',
    },

    {
        'glepnir/lspsaga.nvim',
        branch = 'main',
        config = function()
            require('lspsaga').setup({})
        end,
    },

    {
        'rcarriga/nvim-notify',
        --before = 'reach.nvim',
        event = 'VeryLazy',
        config = function()
            local nvim_notify = require('notify').setup({
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
}

return M
