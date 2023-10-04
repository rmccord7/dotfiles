local M = {

    require('plugins.ui.treesitter'),
    require('plugins.ui.heirline'),
    require('plugins.ui.tree'),
    require('plugins.ui.trouble'),

    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        config = function()
            -- local colors = require('material').colors

            require('ibl').setup({

                -- config = {
                --     scope = {
                --         highlight = colors.editor.border
                --     }
                -- }
            })
        end,
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

    -- {
    --     'rcarriga/nvim-notify',
    --     event = 'VeryLazy',
    --     config = function()
    --         require('notify').setup({
    --             level = vim.log.levels.TRACE,
    --             timeout = 1500,
    --             max_height = function()
    --                 return math.floor(vim.o.lines * 0.75)
    --             end,
    --             max_width = function()
    --                 return math.floor(vim.o.columns * 0.75)
    --             end,
    --             stages = 'fade',
    --             background_colour = require('material.colors').editor.bg,
    --             render = 'compact',
    --         })
    --
    --         vim.notify = function(msg, log_level, opts)
    --             log_level = log_level or vim.log.levels.DEBUG
    --
    --             -- Auto-convert tables to string interpretation so we can print it
    --             if type(msg) == 'table' then
    --                 msg = vim.inspect(msg)
    --             elseif type(msg) == 'number' or type(msg) == 'boolean' then
    --                 msg = tostring(msg)
    --             elseif type(msg) == 'string' then
    --                 -- Ignore the LSP warning for no matching language servers to format with
    --                 if msg == '[LSP] Format request failed, no matching language servers.' then
    --                     return
    --                 end
    --             else
    --                 require('notify')([[Couldn't convert value to a string]], vim.log.levels.ERROR, opts)
    --                 return
    --             end
    --
    --             require('notify')(msg, log_level, opts)
    --         end
    --     end,
    -- },

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
        event = 'VeryLazy',
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end,
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },
}

return M
