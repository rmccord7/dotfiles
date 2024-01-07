local config = function()
    require('reach').setup({})
end

local M = {
    {
        'toppair/reach.nvim',
        config = config,
    },
}

return M
