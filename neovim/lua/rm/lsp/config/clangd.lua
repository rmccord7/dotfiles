local M = {
    -- File types
    file_types = {
        'c',
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
    name = 'clangd', -- Unique LSP server name.
    cmd = { -- Command to start the language server.
        'clangd',
        '--log=verbose',
        '--pretty',
        "--background-index",
        "-j=8",
        "--inlay-hints",
        -- "--malloc-trim",
        "--pch-storage=memory",
        "--header-insertion=never",
        "--header-insertion-decorators",
        "--all-scopes-completion",
        -- "--clang-tidy",
        -- "--clang-tidy-checks=modernize-*,misc-*"
        "--function-arg-placeholders",
        "--completion-style=detailed",
    },
    root_dir = vim.fs.dirname(root_paths[1]), -- Project root directory.
    capabilities = require('cmp_nvim_lsp').default_capabilities(), -- LSP client capabilities.
}

return M
