local config = function()

    vim.lsp.set_log_level(vim.log.levels.OFF)

    local servers = {
        'bashls',
        'clangd',
        'cmake',
        'pyright',
        'rust-analyzer',
        'lua_ls',
    }

    -- Manage LSP Diagnostics
    vim.diagnostic.config({
        underline = false,
        virtual_text = false,
        virtual_lines = false,
        signs = {
            severity = { min = vim.diagnostic.severity.WARN },
        },
        update_in_insert = false,
        float = {
            header = 'Diagnostic',
            source = 'always',
            format = function(diagnostic)
                if diagnostic.code then
                    return string.format('[%s]\n%s', diagnostic.code, diagnostic.message)
                else
                    return diagnostic.message
                end
            end,
        },
    })

    -- Toggle Diagnostics
    nmap('<leader>td', function()
        if vim.b.show_diagnostics then
            vim.diagnostic.hide()
            vim.b.show_diagnostics = false
        else
            vim.diagnostic.show()
            vim.b.show_diagnostics = true
        end
    end, 'Toggle diagnostics', nil)

    -- Close signature help
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'shadow',
        close_events = { 'CursorMoved', 'BufHidden', 'InsertCharPre' },
    })

    -- Handle hover
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = 'shadow',
    })

    -- Advertise to LSP servers that nvim-cmp supports LSP
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Setup all settings when we attach to a buffer for an LSP
    local function on_attach(client, bufnr)
        nmap('<c-s>', ':Lspsaga hover_doc<CR>', nil, { buffer = bufnr })
        nmap('gr', ':Lspsaga rename<CR>', nil, { buffer = bufnr })
        nmap('<leader>ca', ':Lspsaga code_action<CR>', nil, { buffer = bufnr })
        vmap('<leader>ca', ':Lspsaga code_action<CR>', nil, { buffer = bufnr })
        nmap('<leader>cd', ':Lspsaga show_line_diagnostics<CR>', nil, { buffer = bufnr })
        nmap('<leader>cD', ':Lspsaga cursor_line_diagnostics<CR>', nil, { buffer = bufnr })
        nmap(']e', ':Lspsaga diagnostic_jump_next<CR>zz', nil, { buffer = bufnr })
        nmap('[e', ':Lspsaga diagnostic_jump_prev<CR>zz', nil, { buffer = bufnr })
        nmap('gh', ':Lspsaga lsp_finder<CR>', nil, { buffer = bufnr })
        nmap('<leader>f', ':Format<CR>', nil, { buffer = bufnr })

        -- client.server_capabilities.semanticTokensProvider = nil
        -- client.server_capabilities.completionProvider = false

        -- Show diagnostics on attach
        vim.b.show_diagnostics = true
    end

    local ok, _ = pcall(require, 'lspconfig')

    if ok then
        require('neodev').setup({})

        for _, server in ipairs(servers) do
            require('plugins.lspconfig.servers.' .. server).setup(on_attach, capabilities)
        end
    end
end

local M = {

    {
        'neovim/nvim-lspconfig',
        config = config,
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
        },
    },
}

return M
