local lspconfig = require('lspconfig')

local M = {}

function M.setup(hooks)
  lspconfig.rust_analyzer.setup({

    on_attach = hooks.my_on_attach,
    capabilities = hooks.my_capabilities,

    cmd = {
      'yaml-language-server',
      '--stdio',
    },

    settings = {
      yaml = {
        validate = true,
        hover = true,
        format = {
          enable = true,
          singleQuote = true,
        },
        schemaStore = {
          url = 'https://www.schemastore.org/api/json/catalog.json',
        },
        schemas = {
          ['uwb.logging.schema.json'] = 'log_*.yaml',
        },
      },
    },
  })
end

return M
