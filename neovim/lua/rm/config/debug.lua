local path = require('rm.util.path')

local M = {
  enable = false, -- Enable neovim config debug messages

  log = { -- Logging options

    lsp = { -- LSP logging
      enable = false, -- Enable LSP logging
      level = vim.lsp.log_levels.DEBUG, -- LSP log level
      dir = path.nvim_log, -- LSP log output directory
    },
  },
}

return M
