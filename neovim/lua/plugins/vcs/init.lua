local M = {

    {
        'nfvs/vim-perforce',
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

}

return M
