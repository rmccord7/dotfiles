local lspconfig = require("lspconfig")

local M = {}

M.setup = {

    lspconfig.rust_analyzer.setup {

        cmd = {
            'rust_analyzer',
        },

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
    }
}

return M
