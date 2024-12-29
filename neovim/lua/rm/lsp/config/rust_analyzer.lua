local lspconfig = require('lspconfig')

local M = {}

function M.setup(hooks)
  lspconfig.rust_analyzer.setup({

    on_attach = hooks.my_on_attach,
    capabilities = hooks.my_capabilities,

    cmd = {
      'rust_analyzer',
    },

    settings = {
      ['rust-analyzer'] = {
        imports = {
          granularity = {
            group = 'module',
          },
          prefix = 'self',
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  })
end

return M
