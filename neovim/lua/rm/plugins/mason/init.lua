local config = function()
    local ok, plugin = pcall(require, 'mason')

    if not ok then
        return
    end

    plugin.setup({
        providers = {
            'mason.providers.client',
            'mason.providers.registry-api',
        },
        --log_level = vim.log.levels.DEBUG,
    })

    -- Load our internal LSP config
    require('rm.lsp')
end

local M = {
    {
        'williamboman/mason.nvim',
        config = config,
    },
}

return M
