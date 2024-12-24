local config = function()
  require("gitsigns").setup()
end

local M = {
  {
    "lewis6991/gitsigns.nvim",
    config = config,
  },
}

return M
