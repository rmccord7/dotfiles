local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local library_files = {
    vim.api.nvim_get_runtime_file('', true),
    vim.fn.expand('~/dotfiles/neovim/lua'),
    vim.fn.expand('~/.local/share/nvim/lazy/telescope.nvim/lua'),
    -- vim.fn.expand('~/projects/p4.nvim/lua'),
}

local _M = {}

_M.setup = function(on_attach, capabilities)
    require('lspconfig').lua_ls.setup({
        cmd = {
            'lua-language-server',
            -- '--logpath=' .. './log',
            -- '--metapath=' .. './meta',
        },
        filetypes = { 'lua' },
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = require('lspconfig').util.root_pattern({'stylua.toml', '.stylua.toml', '.luacheckrc', '.nvim.lua', 'compile_commands.json', '.git'}),
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = runtime_path,
                },
                diagnostics = {
                    globals = {
                        'vim',
                        'package',
                    },
                    disable = {
                        'lowercase-global',
                    },
                },
                workspace = {
                    checkThirdParty = false,
                    library = library_files,
                },
            },
        },
        commands = {
            Format = {
                function()
                    --require('stylua-nvim').format_file(global.home_path .. '/dotfiles/neovim/stylua.toml')
                    require('stylua-nvim').format_file()
                end,
            },
        },
        single_file_support = true,
    })
end

return _M
