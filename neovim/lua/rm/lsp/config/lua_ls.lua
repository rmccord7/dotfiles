local nvim_config = require('rm.config')
local util_path = require('rm.util.path')

-- Add lua directories to runtime path that is supplied to the LSP
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- Additional Workspace files when working with lua
local library_files = {
    vim.api.nvim_get_runtime_file('', true),
    util_path.os_path(vim.fn.expand('~/dotfiles/neovim/lua')),
    util_path.os_path(vim.fn.expand(nvim_config.path.plugins .. '/telescope.nvim/lua')), -- Go to telescope definitions
}

local M = {
    -- File types
    file_types = {
        'lua',
    },

    -- LSP root file/directory markers.
    root_files = {
        '.nvim.lua',
        '.git',
        '.stylua.toml',
        'stylua.toml',
        '.luacheckrc'
    }
}

-- LSP root file paths in order root files were found.
local root_paths = vim.fs.find(M.root_files, { upward = true })

-- LSP config
M.lsp = {
    name = 'lua-language-server', -- Unique LSP server name.
    cmd = { -- Command to start the language server.
        'lua-language-server',
        '--logpath=' .. util_path.os_path(nvim_config.path.nvim_log .. '/lsp/lua'),
        -- '--metapath=' .. './meta',
    },
    before_init = require('neodev.lsp').before_init, -- Neodev needs to be run before the lua-language-server starts.
    root_dir = vim.fs.dirname(root_paths[1]), -- Project root directory.
    capabilities = require('cmp_nvim_lsp').default_capabilities(), -- LSP client capabilities.
    settings = {
        Lua = {
            runtime = { -- Lua runtime
                version = 'LuaJIT', -- Use neovim LUAJIT runtime
                path = runtime_path, -- Point to neovim runtime
            },
            diagnostics = {
                globals = { -- Ignore missing globals
                    'vim', -- Ignore Neovim missing vim global
                    -- 'package', -- Ignore Neovim missing package
                },
                disable = { -- Disable diagnostics
                    'lowercase-global', -- Disable global variable not capitilized
                },
            },
            workspace = { -- External workspace
                checkThirdParty = false, -- Look for external lua modules
                library = library_files, -- Point to external lua modules
            },
        }
    },
    commands = { -- LSP commands
        Format = { -- LSP format command
            -- Format the lua buffer using the stylua-nvim plugin.
            function()
                require('stylua-nvim').format_file()
            end,
        },
    },
}

return M
