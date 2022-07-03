local global = require('global')
local lspconfig = require('lspconfig')

-- Setup sumneko binary path
local sumneko_root_path
local sumneko_binary

if global.is_linux  then
  sumneko_root_path = global.home .. "/.local/bin/lua-language-server"
  sumneko_binary    = sumneko_root_path .. "/bin/lua-language-server"
elseif global.is_windows then
  sumneko_root_path = global.home .. "/bin/lua-language-server"
  sumneko_binary    = sumneko_root_path .. "/bin/lua-language-server"
else
  if global.is_mac then
    sumneko_root_path = global.home .. "/.local/bin/lua-language-server"
    sumneko_binary    = sumneko_root_path .. "/bin/macOS/lua-language-server"
  end
end

-- Add lua directories to runtime path
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local _M = {}

_M.setup = function(on_attach, capabilities)

    require("lspconfig").sumneko_lua.setup {

      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
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
