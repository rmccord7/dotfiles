local lspconfig = require('lspconfig')

local _M = {}

_M.setup = function(on_attach, capabilities)

    require("lspconfig").bashls.setup {

        on_attach = on_attach,
        flags = {

            debounce_text_changes = 150,

        },
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern('compile_commands.json', 'compile_flags.txt', '.git'),
        cmd = {'bash-language-server'},
        args = {'start'},
        cmd_env = {GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"},
        fileypes = {'sh', 'zsh'},
        single_file_support = true
    }
end

return _M
