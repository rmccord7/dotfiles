local M = {

    {
        'NvChad/nvim-colorizer.lua',
        module = false,
        config = function()
            require('colorizer').setup({
                user_default_options = {
                    mode = 'virtualtext',
                    names = false,
                },
            })
        end,
    },

    {
        'Eandrju/cellular-automaton.nvim',
    },
}

return M
