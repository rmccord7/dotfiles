local nvim_config = require('config')
local path = require('util.path')

local config = function()
    require('p4').setup()
end

local M = {
    {
       'rmccord7/p4.nvim',
        config = config,
        dir = path.os_path(nvim_config.path.home .. '/.local/share/nvim/dev/p4.nvim'),
        -- dev = true,
    },
}

return M
