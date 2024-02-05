local M = {
    -- File types
    file_types = {
        'rs',
    },

    -- LSP root file/directory markers.
    root_files = {
        '.Cargo.toml',
        '.nvim.lua',
        '.git',
    },
}

-- LSP root file paths in order root files were found.
local root_paths = vim.fs.find(M.root_files, { upward = true })

-- LSP config
M.lsp = {
    name = 'rust', -- Unique LSP server name.
    cmd = { -- Command to start the language server.
        'rust_analyzer',
    },
    root_dir = vim.fs.dirname(root_paths[1]), -- Project root directory.
    capabilities = require('cmp_nvim_lsp').default_capabilities(), -- LSP client capabilities.
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

return M
