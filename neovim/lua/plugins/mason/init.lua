local config = function()
    require('mason').setup({
        providers = {
            'mason.providers.client',
            'mason.providers.registry-api',
        },
        --log_level = vim.log.levels.DEBUG,
    })

    -- Load LSP
    require('lsp')
end

local M = {
    {
        'williamboman/mason.nvim',
        config = config,
        dependencies = {
            'folke/neodev.nvim', -- Include for lua language server
        },
    },
}

return M

