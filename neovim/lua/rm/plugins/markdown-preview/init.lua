return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install && git restore .",
  ft = { "markdown" },
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_auto_start = 0
  end,
}
