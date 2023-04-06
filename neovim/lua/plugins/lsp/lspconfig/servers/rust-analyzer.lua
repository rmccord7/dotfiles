local lspconfig = require('lspconfig')

local _M = {}

_M.setup = function(on_attach, capabilities)
    require('lspconfig').rust_analyzer.setup({
        cmd = { 'rust-analyzer' },
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern('Cargo.toml', '.git'),
        capabilities = capabilities,
        single_file_support = true,
        settings = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true
                },
            }
        }
    })
end

return _M
