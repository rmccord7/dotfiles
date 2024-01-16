-- LSP root file/directory markers.
local root_files = {
    'compile_commands.json',
    'compile_flags.txt',
    '.nvim.lua',
    '.p4config',
    '.git',
}

-- LSP root file paths in order root files were found.
local root_paths = vim.fs.find(root_files, { upward = true })

-- LSP setup config
local config = {
    name = 'clangd', -- Unique LSP server name.
    cmd = { -- Command to start the language server.
        'clangd',
        '--log=verbose',
        -- '--pretty',
        -- "--background-index",
        -- "-j=8",
        -- "--malloc-trim",
        -- "--pch-storage=memory",
        -- "--header-insertion=never",
        -- "--all-scopes-completion",
        -- "--clang-tidy",
        -- "--clang-tidy-checks=modernize-*,misc-*"
    },
    root_dir = vim.fs.dirname(root_paths[1]), -- Project root directory.
    capabilities = require('cmp_nvim_lsp').default_capabilities(), -- LSP client capabilities.
}

-- Start the LSP server after the buffer file type has been set.
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'c'},
    desc = 'Start Lua LSP',
    callback = function()
        vim.lsp.start(config)
    end,
})
