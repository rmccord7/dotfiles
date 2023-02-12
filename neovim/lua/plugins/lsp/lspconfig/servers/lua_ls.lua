local global = require('global')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local library_files = vim.api.nvim_get_runtime_file('', true)

-- add local nvim config to enable goto definitions, etc
table.insert(library_files, global.home_path .. '/dotfiles/neovim/lua')

local _M = {}

_M.setup = function(on_attach, capabilities)
    require('lspconfig').lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = require('lspconfig').util.root_pattern({'compile_commands.json', '.nvimrc.lua', '.git', 'stylua.toml', '.stylua.toml'}),
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
                    library = library_files,
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
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
