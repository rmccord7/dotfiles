local lspconfig = require('lspconfig')

-- Add lua directories to runtime path
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local _M = {}

_M.setup = function(on_attach, capabilities)

    require("lspconfig").sumneko_lua.setup {

      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern('.git'),
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = runtime_path,
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      },
      single_file_support = true
    }
end

return _M
