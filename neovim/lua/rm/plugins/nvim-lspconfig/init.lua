return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
  },
  config = function(_, _)
    require("rm.lsp")
  end,
}
