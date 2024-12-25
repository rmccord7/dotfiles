local config = function()
  local ok, plugin = pcall(require, "diffview")

  if not ok then
    return
  end

  plugin.setup()

  vim.keymap.set({"n"}, "<leader>do", [[:DiffviewOpen]], { nowait = true, desc = "Diffview Open" })
  vim.keymap.set({"n"}, "<leader>dh", [[:DiffviewFileHistory]], { nowait = true, desc = "Diffview File History" })
  vim.keymap.set({"n"}, "<leader>dc", [[:DiffviewClose<CR>]], { desc = "Diffview Close" })
end

local M = {
  {
    "sindrets/diffview.nvim",
    config = config,
  },
}

return M
