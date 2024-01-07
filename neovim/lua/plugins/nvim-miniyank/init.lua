local config = function()
    require('neoclip').setup()
end

local M = {
    {
        'AckslD/nvim-neoclip.lua',
        config = config,
    },
}

return M
