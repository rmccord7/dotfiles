local servers = {
    'lua', -- Lua-language-server
}

for _, server in ipairs(servers) do
    require('lsp.servers.' .. server)
end

-- LSP Autocmds
-- highlight yank for a brief second for visual feedback
vim.api.nvim_create_autocmd('LSPAttach', {
    desc = 'LSP Actions',
    callback = function(args)

        local bufnr = args.buf
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)

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
    end,
})
