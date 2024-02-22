local nvim_config = require('rm.config')
local path = require('rm.util.path')

local config = function()
    local ok, plugin = pcall(require, 'ss1pwn')

    if not ok then
        return
    end
end

local M = {
    {
        'rmccord7/ss1pwn',
        config = config,
        dir = path.os_path(nvim_config.path.nvim_data .. '/dev/ss1pwn'),
        -- dev = true,
        ft = 'c',
    },
}

return M
