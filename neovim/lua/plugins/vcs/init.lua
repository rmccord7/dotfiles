local global = require('global')

local M = {

    {
        'nfvs/vim-perforce',
        enabled = false,
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    },

    {
        'mhinz/vim-signify',
        enabled = false,
    },

    {
        'nfvs/vim-perforce',
    },

    {
        'sindrets/diffview.nvim',
        config = function()
            require('diffview').setup()
        end,
    },

    {
        'tpope/vim-fugitive',
    },

    {
       'rmccord7/p4.nvim',
        config = function()
            require('p4').setup()
        end,
        dir = global.home_path .. '/p4.nvim',
        dev = true,
    },
}

return M
