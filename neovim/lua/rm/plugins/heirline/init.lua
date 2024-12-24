local config = function()
  --TODO: pcall?
  require("nvim-web-devicons").setup({})

  local ok, plugin = pcall(require, "heirline")

  if not ok then
    return
  end

  plugin.setup({
    statusline = require("rm.plugins.heirline.statusline"),
  })
end

local M = {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = config,
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "kyazdani42/nvim-web-devicons",
    },
  },
}

return M
