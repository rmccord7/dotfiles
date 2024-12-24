local config = function()
  local ok, _ = pcall(require, "markdown-preview")

  if not ok then
    return
  end

  vim.g.mkdp_auto_start = 0
end

local M = {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    config = config,
  },
}

return M
