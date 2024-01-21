local config = function()
    require('neoclip').setup()

    map('', 'p', '<Plug>(miniyank-autoput)', 'Override put for miniyank')
    map('', 'P', '<Plug>(miniyank-autoPut)', 'Override put for miniyank')

    map('', '<leader>p', '<Plug>(miniyank-cycle)', 'Miniyank cycle next')
    map('', '<leader>P', '<Plug>(miniyank-cycleback)', 'Miniyank cycle previous')
end

local M = {
    {
        'AckslD/nvim-neoclip.lua',
        config = config,
    },
}

return M
