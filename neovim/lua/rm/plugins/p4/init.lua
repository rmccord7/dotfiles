-- local nvim_config = require('rm.config')
-- local path = require('rm.util.path')

local config = function()
  local ok, _ = pcall(require, "p4")

  if not ok then
    return
  end

  vim.keymap.set({"n"}, "<leader>pc", [[:P4 Display_CLs<CR>]], { nowait = true, desc = "Open picker for the current client's CLs" })
  vim.keymap.set({"n"},
    "<leader>po",
    [[:P4 Display_Open_Files<CR>]],
    { nowait = true, desc = "Open picker for the current client's open files" })
end

local M = {
  {
    "rmccord7/p4.nvim",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-telescope/telescope.nvim",
    },
    config = config,
    dev = true,
  },
}

return M
