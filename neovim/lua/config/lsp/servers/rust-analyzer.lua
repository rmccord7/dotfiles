local _M = {}

_M.setup = function(on_attach, capabilities)

    require("lspconfig").rust_analyzer.setup {
        cmd = {'rust-analyzer'},
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
        single_file_support = true
    }
end

return _M
