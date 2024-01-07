local global = require('global')

local config = function()
    require('p4').setup()
end

local M = {
    {
       'rmccord7/p4.nvim',
        config = config,
        dir = global.home_path .. '/.local/share/nvim/dev/p4.nvim',
        -- dev = true,
    },
}

return M
