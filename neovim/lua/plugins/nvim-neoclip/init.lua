local config = function()
    require('Comment').setup()

    nmap('<leader>"', [[:Telescope neoclip<CR>]], 'Neoclip')
end

local M = {
    {
        'numToStr/Comment.nvim',
        config = config,
    },
}

return M
