-- Global diagnostic actions regardless of LSP
nmap('<space>e', vim.diagnostic.open_float, 'List Diagnostics')
nmap('[d', vim.diagnostic.goto_prev, 'GoTo Previous Diagnostic')
nmap(']d', vim.diagnostic.goto_next, 'GoTo Next Diagnostic')
nmap('<space>q', vim.diagnostic.setloclist, 'Set Loc List With Diagnostics')

-- Set LSP actions when LSP attaches to a buffer
vim.api.nvim_create_autocmd('LSPAttach', {
    desc = 'LSP Actions',
    callback = function(args)

        local bufnr = args.buf
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)

        nmap('K', vim.lsp.buf.hover, 'LSP Hover', { buffer = bufnr })
        nmap('gi', vim.lsp.buf.implementation, 'LSP GoTo implementation', { buffer = bufnr })
        nmap('gd', vim.lsp.buf.definition, 'LSP GoTo Definition', { buffer = bufnr })
        nmap('gD', vim.lsp.buf.declaration, 'LSP GoTo Declaration', { buffer = bufnr })
        nmap('<C-k>', vim.lsp.buf.signature_help, 'LSP Signatute Help', { buffer = bufnr })
        nmap('<space>wa', vim.lsp.buf.add_workspace_folder, 'LSP Add Workspace Folder', { buffer = bufnr })
        nmap('<space>wr', vim.lsp.buf.remove_workspace_folder, 'LSP Remove Workspace Folder', { buffer = bufnr })
        nmap('<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'LSP List Workspace Folders', { buffer = bufnr })
        nmap('<space>D', vim.lsp.buf.type_definition, 'LSP GoTo Type Definition', { buffer = bufnr })
        nmap('<space>r', vim.lsp.buf.rename, 'LSP Rename', { buffer = bufnr })

        nmap('<leader>ca', vim.lsp.buf.code_action, 'LSP Code Action', { buffer = bufnr })
        vmap('<leader>ca', vim.lsp.buf.code_action, 'LSP Code Action', { buffer = bufnr })

        nmap('gr', vim.lsp.buf.references, 'LSP List References', { buffer = bufnr })
        nmap('<leader>f', function() vim.lsp.buf.format { async = true } end, 'LSP Format', { buffer = bufnr })
    end,
})

