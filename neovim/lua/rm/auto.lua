--- Highlight yank for a brief second for visual feedback.
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ on_visual = false })
  end,
})

--- Easy quit man pages.
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "man" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>q<cr>", {
      buffer = true,
      silent = true,
    })
  end,
})

--- Easy quit help pages.
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "help", "startuptime", "qf", "lspinfo" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = true,
      silent = true,
    })
  end,
})
