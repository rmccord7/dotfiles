local lspconfig = require('lspconfig')

local _M = {}

_M.setup = function(on_attach, capabilities)

    require("lspconfig").pyright.setup {
        cmd = {'pyright-langserver', '--stdio'},
        root_dir = lspconfig.util.root_pattern('compile_commands.json', 'compile_flags.txt', '.git'),
        filetypes = {'python'},
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
        single_file_support = true
    }
end

return _M
