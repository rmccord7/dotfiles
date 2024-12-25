local config = function()
  local ok, plugin = pcall(require, "todo-comments")

  if not ok then
    return
  end

  plugin.setup({})

  vim.keymap.set({"n"}, "<leader>td", [[:TodoTelescope<CR>]], { desc = "Todo Telescope" })
end

local M = {
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = config,
  },
}

return M
