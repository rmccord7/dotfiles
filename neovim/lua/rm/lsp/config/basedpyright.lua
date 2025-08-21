vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
      typeCheckingMode = 'standard',
    },
  },
})

vim.lsp.enable 'ruff'
