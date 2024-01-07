local config = function()
    require('mason-lspconfig').setup({
        ensure_installed = {
            'bashls',
            'lua_ls',
            'rust_analyzer',
            'clangd',
            'pyright',
        },
    })
end

local M = {
    {
        'williamboman/mason-lspconfig.nvim',
    },
}

return M
