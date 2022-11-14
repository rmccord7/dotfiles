local global = require('global')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local library_files = vim.api.nvim_get_runtime_file('', true)
-- add local nvim config to enable goto definitions, etc
table.insert(library_files, global.home_path .. '/dotfiles/neovim/lua')

local _M = {}

_M.setup = function(on_attach, capabilities)

  require('lspconfig').sumneko_lua.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = require('lspconfig').util.root_pattern('.git'),
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
          disable  = {
            'lowercase-global',
          }
        },
        workspace = {
          library = library_files,
        },
        telemetry = {
          enable = false,
        },
      },
    },
    single_file_support = true
  }
end

return _M
