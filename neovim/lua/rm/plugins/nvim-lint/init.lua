local config = function()
  local ok, lint = pcall(require, "lint")

  if not ok then
    return
  end

  local api = vim.api

  -- Linting –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
  local lint_group = api.nvim_create_augroup("lint", { clear = true })
  api.nvim_create_autocmd({
    "FileReadPost",
    "InsertLeave",
    "BufWritePost",
    "TextChanged",
    "ModeChanged",
    "FocusGained",
  }, {
    group = lint_group,
    callback = function()
      lint.try_lint()
    end,
  })
end

local M = {
  {
    "mfussenegger/nvim-lint",
    config = config,
  },
}

return M
