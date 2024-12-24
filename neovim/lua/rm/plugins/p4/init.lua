-- local nvim_config = require('rm.config')
-- local path = require('rm.util.path')

local config = function()
  local ok, _ = pcall(require, "p4")

  if not ok then
    return
  end

  nmap("<leader>pc", [[:P4 Display_CLs<CR>]], "Open picker for the current client's CLs", { nowait = true })
  nmap(
    "<leader>po",
    [[:P4 Display_Open_Files<CR>]],
    "Open picker for the current client's open files",
    { nowait = true }
  )
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
