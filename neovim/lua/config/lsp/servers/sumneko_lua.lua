-- Add lua directories to runtime path
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local _M = {}

_M.setup = function(on_attach, capabilities)

  local luadev = require('lua-dev').setup({

    runtime_path = true,
    lspconfig = {
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
            globals = {'vim'},
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      },
      single_file_support = true
    }
  })

  require("lspconfig").sumneko_lua.setup(luadev)
end

return _M
