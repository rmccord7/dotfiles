local config = function()
  local ok, plugin = pcall(require, "colorizer")

  if not ok then
    return
  end

  plugin.setup({
    user_default_options = {
      mode = "virtualtext",
      names = false,
    },
  })
end

local M = {
  {
    "NvChad/nvim-colorizer.lua",
    module = false,
    config = config,
  },
}

return M
