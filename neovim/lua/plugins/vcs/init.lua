local M = {

    {
        'nfvs/vim-perforce',
    },

    {
        'mhinz/vim-signify',
        enabled = false,
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
