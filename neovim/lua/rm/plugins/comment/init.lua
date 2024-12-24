local config = function()
  local ok, plugin = pcall(require, "Comment")

  if not ok then
    return
  end

  plugin.setup()
end

local M = {
  {
    "numToStr/Comment.nvim",
    config = config,
  },
}

return M
