local nvim_config = require('rm.config')
local path = require('rm.util.path')

local config = function()
    local ok, plugin = pcall(require, 'p4')

    if not ok then
        return
    end

    plugin.setup()
end

local M = {
    {
       'rmccord7/p4.nvim',
       dependencies = {'nvim-telescope/telescope.nvim'},
        config = config,
        --dir = path.os_path(nvim_config.path.nvim_data .. '/dev/p4.nvim'),
        dev = true,
    },
}

return M
