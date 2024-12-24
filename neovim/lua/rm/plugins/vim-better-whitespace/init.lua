local config = function()
  -- Disable whitespace highlighting
  vim.g.better_whitespace_enabled = 0

  -- Strip whitespace on save for modified lines
  vim.g.strip_whitespace_on_save = 1
  vim.g.strip_only_modified_lines = 1

  -- Don't strip newlines at eof
  vim.g.strip_whitelines_at_eof = 0

  -- Don't ask for confirmation when whitespace is removed
  vim.g.strip_whitespace_confirm = 0

  -- Disable plugin for the following file types
  vim.g.better_whitespace_filetypes_blacklist = {
    "dashboard",
    "diff",
    "git",
    "gitcommit",
    "unite",
    "nvimtree",
    "markdown",
    "fugitive",
    "qf",
    "help",
  }
end

local M = {
  {
    "ntpeters/vim-better-whitespace",
    config = config,
  },
}

return M
