vim.lsp.config('yamlls', {
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

