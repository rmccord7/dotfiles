local M = {

    require('plugins.lsp.lspconfig'),

    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                providers = {
                    'mason.providers.client',
                    'mason.providers.registry-api',
                },
                log_level = vim.log.levels.DEBUG,
            })
        end,
    },

    {
        'williamboman/mason-lspconfig.nvim',
        -- after = { 'mason.nvim' },
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls',
                    'lua_ls',
                    'rust_analyzer',
                    'clangd',
                    'pyright',
                    'cmake',
                },
            })
        end,
    },
}

return M
