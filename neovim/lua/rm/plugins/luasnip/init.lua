local config = function()
    local ok, _ = pcall(require, 'luasnip')

    if not ok then
        return
    end

    require('rm.plugins.luasnip.lua')
end

local M = {

    {
        'L3MON4D3/LuaSnip',
        config = config,
        event = {'InsertEnter', 'CmdlineEnter'},
    },
}

return M
