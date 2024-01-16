-- LSP root file/directory markers.
local root_files = {
    '.Cargo.toml',
    '.nvim.lua',
    '.git',
}

-- LSP root file paths in order root files were found.
local root_paths = vim.fs.find(root_files, { upward = true })

-- LSP config
local settings = {
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

-- LSP setup config
local config = {
    name = 'rust', -- Unique LSP server name.
    cmd = { -- Command to start the language server.
        'rust_analyzer',
    },
    root_dir = vim.fs.dirname(root_paths[1]), -- Project root directory.
    capabilities = require('cmp_nvim_lsp').default_capabilities(), -- LSP client capabilities.
    settings = settings, -- LSP settings
}

-- Start the LSP server after the buffer file type has been set.
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'rs'},
    desc = 'Start Lua LSP',
    callback = function()
        vim.lsp.start(config)
    end,
})
