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
}

return M
