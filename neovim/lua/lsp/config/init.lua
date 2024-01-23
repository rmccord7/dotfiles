local M = {
    'clangd',
    'lua',
    'rust',
}

-- Start the LSP server after the buffer file type has been set.
for _, name in ipairs(M) do
    local config = require('lsp.config.' .. name)

    vim.api.nvim_create_autocmd('FileType', {
        pattern = config.file_types,
        desc = 'Start LSP: ' .. config.lsp.name,
        callback = function()
            vim.lsp.start(config.lsp)
        end,
    })
end


return M
