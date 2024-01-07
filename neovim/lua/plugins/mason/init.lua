local config = function()
    require('mason').setup({
        providers = {
            'mason.providers.client',
            'mason.providers.registry-api',
        },
        log_level = vim.log.levels.DEBUG,
    })
end

local M = {
    {
        'williamboman/mason.nvim',
        config = config,
    },

    require('plugins.mason.lspconfig')
}

return M

