local config = function()
  local ok, plugin = pcall(require, "nvim-surround")

  if not ok then
    return
  end

  plugin.setup()
end

local M = {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = config,
  },
}

return M
