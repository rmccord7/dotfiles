local config = function()
    local ok, _ = pcall(require, 'luasnip')

    if not ok then
        return
    end

    local config = require('rm.config')
    local path_util = require('rm.util.path')

    -- Set up actual snippets
    require('luasnip.loaders.from_vscode').lazy_load({ paths = { config.path.plugin_config .. path_util.os_path('/luasnip/vscode/') } })
    require('luasnip.loaders.from_lua').load()
end

local M = {

    {
        'L3MON4D3/LuaSnip',
        config = config,
        event = {'InsertEnter', 'CmdlineEnter'},
        version = "v2.*",
        build = "make install_jsregexp"
    },
}

return M
