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
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    config = config,
  },
}

return M
