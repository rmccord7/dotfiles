local lspconfig = require('lspconfig')

local _M = {}

_M.setup = function(on_attach, capabilities)
    require('lspconfig').bashls.setup({

        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('.git'),
        fileypes = { 'sh', 'zsh' },
        settings = {
            bashIde = {
                globPattern = "*@(.sh|.zsh|.inc|.bash|.command)"
            }
        }
    })
end

return _M
