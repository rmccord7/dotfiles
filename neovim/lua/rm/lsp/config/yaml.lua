local M = {
    -- File types
    file_types = {
        'yaml',
    },

    -- LSP root file/directory markers.
    root_files = {
        'compile_commands.json',
        'compile_flags.txt',
        '.clangd',
        '.nvim.lua',
        '.p4config',
        '.git',
    },
}

-- LSP root file paths in order root files were found.
local root_paths = vim.fs.find(M.root_files, { upward = true })

-- LSP config
M.lsp = {
    name = 'yaml', -- Unique LSP server name.
    cmd = { -- Command to start the language server.
        'yaml-language-server',
        '--stdio',
    },
    root_dir = vim.fs.dirname(root_paths[1]), -- Project root directory.
    capabilities = require('cmp_nvim_lsp').default_capabilities(), -- LSP client capabilities.
    settings = {
        yaml = {
            validate = true,
            hover = true,
            format = {
                enable = true,
                singleQuote = true
            },
            schemaStore = {
                url = "https://www.schemastore.org/api/json/catalog.json"
            },
            schemas = {
                ["uwb.logging.schema.json"] = "log_*.yaml",
            },
        },
    },
}

return M
