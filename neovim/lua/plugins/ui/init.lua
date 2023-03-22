local M = {

    require('plugins.ui.treesitter'),
    --require('plugins.ui.feline'),
    require('plugins.ui.heirline'),
    require('plugins.ui.material'),
    require('plugins.ui.tree'),
    require('plugins.ui.trouble'),

    {
        'lukas-reineke/indent-blankline.nvim',
    },

    {
        'glepnir/lspsaga.nvim',
        event = "BufRead",
        branch = 'main',
        config = function()
            require('lspsaga').setup({
                outline = {
                    win_position = "left",
                },
            })
        end,
    },

    {
        'rcarriga/nvim-notify',
        --before = 'reach.nvim',
        event = 'VeryLazy',
        config = function()
            require('notify').setup({
                level = vim.log.levels.TRACE,
                timeout = 1500,
                stages = 'fade',
                background_colour = require('material.colors').editor.bg,
                render = 'compact',
                top_down = false,
            })

            ---@diagnostic disable-next-line: duplicate-set-field
            vim.notify = function(msg, log_level, opts)
                log_level = log_level or vim.log.levels.DEBUG

                -- Auto-convert tables to string interpretation so we can print it
                if type(msg) == 'table' then
                    msg = vim.inspect(msg)
                elseif type(msg) == 'number' or type(msg) == 'boolean' then
                    msg = tostring(msg)
                elseif type(msg) == 'string' then
                    -- Ignore the LSP warning for no matching language servers to format with
                    if msg == '[LSP] Format request failed, no matching language servers.' then
                        return
                    end
                else
                    require('notify')([[Could'nt convert value to a string]], vim.log.levels.ERROR, opts)
                    return
                end

                require('notify')(msg, log_level, opts)
            end
        end,
    },

    {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup({
                -- plugins = {
                --     marks = false,
                --     registers = false,
                --     presets = {
                --         operators = false,
                --         text_objects = false,
                --         motions = false,
                --         windows = false,
                --         nav = false,
                --         z = false,
                --         g = false,
                --     },
                -- },
                -- triggers_blacklist = {
                --     n = {
                --         'y',
                --         'd',
                --     },
                -- },
            })
        end,
    },

    {
        'folke/noice.nvim',
        config = function()
            -- Noice has problems with neovide
            ---@diagnostic disable-next-line: undefined-field
            if not vim.g.neovide then
                require('noice').setup()
            end
        end,
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },
}

return M
