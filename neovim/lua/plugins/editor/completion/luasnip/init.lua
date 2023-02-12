local config = function()
    require('plugins.editor.completion.luasnip.snippets.all')
end

local M = {

    {
        'L3MON4D3/LuaSnip',
        config = config,
    },
}

return M
