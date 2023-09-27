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
                },
            })
        end,
    },
    {
        'lvimuser/lsp-inlayhints.nvim',
        event = 'LspAttach',
        branch = 'anticonceal',
        opts = {},
        init = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('LspAttach_inlayhints', {}),
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require('lsp-inlayhints').on_attach(client, args.buf)
                end,
            })
        end,
        config = function()
            require('lsp-inlayhints').setup({
                enabled_at_startup = false,
            })
        end,
    },
}

return M
