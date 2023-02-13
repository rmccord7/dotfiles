local config = function()
    require('plugins.editor.completion.luasnip.snippets')
end

local M = {

    {
        'L3MON4D3/LuaSnip',
        config = config,
        event = 'InsertEnter',
    },
}

return M
