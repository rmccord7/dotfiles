local lspconfig = require("lspconfig")

local M = {}

function M.setup(hooks)
  lspconfig.clangd.setup({

    on_attach = hooks.my_on_attach,
    capabilities = hooks.my_capabilities,

    cmd = { -- Command to start the language server.
      "clangd",
      "--log=verbose",
      "--pretty",
      "--background-index",
      "-j=8",
      "--inlay-hints",
      -- "--malloc-trim",
      "--pch-storage=memory",
      "--header-insertion=never",
      "--header-insertion-decorators",
      "--all-scopes-completion",
      -- "--clang-tidy",
      -- "--clang-tidy-checks=modernize-*,misc-*"
      "--function-arg-placeholders",
      "--completion-style=detailed",
    },
  })
end

return M
