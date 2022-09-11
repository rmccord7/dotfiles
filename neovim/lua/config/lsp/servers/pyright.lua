local lspconfig = require('lspconfig')

local _M = {}

_M.setup = function(on_attach, capabilities)

  require("lspconfig").pyright.setup {
    root_dir = lspconfig.util.root_pattern('pyproject.toml'),
    filetypes = {'python', 'scons', 'api'},
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          autoImportCompletions = true,
          diagnosticMode = 'openFilesOnly',
          useLibraryCodeForTypes = true,
          extraPaths = {
          },
        }
      }
    }
  }
end

return _M
