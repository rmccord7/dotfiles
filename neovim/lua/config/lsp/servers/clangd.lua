local lspconfig = require('lspconfig')

local _M = {}

_M.setup = function(on_attach, capabilities)
    require('lspconfig').clangd.setup({

        --cmd = { 'clangd.exe', '--pretty', '--log=verbose'},
        on_attach = on_attach,
        flags = {

            debounce_text_changes = 150,
        },
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('compile_commands.json', 'compile_flags.txt', '.git'),
        init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
        },
        single_file_support = true,
    })
end

return _M
