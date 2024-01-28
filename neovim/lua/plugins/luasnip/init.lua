local config = function()
    local ok, _ = pcall(require, 'LuaSnip')

    if not ok then
        return
    end

    require('plugins.luasnip.lua')
end

local M = {

    {
        'L3MON4D3/LuaSnip',
        config = config,
        event = {'InsertEnter', 'CmdlineEnter'},
    },
}

return M
