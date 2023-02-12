local M = {

    require('plugins.editor.navigation'),
    require('plugins.editor.completion'),

    require('plugins.editor.easy-align'),

    {
        'tpope/vim-abolish',
    },

    {
        'kylechui/nvim-surround',
        config = function()
            require('nvim-surround').setup({})
        end,
    },

    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end,
    },


    {
        'bfredl/nvim-miniyank',
    },

    {
        'AckslD/nvim-neoclip.lua',
        config = function()
            require('neoclip').setup()
        end,
    },


    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    },

    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup({})
        end,
    },

}

return M
