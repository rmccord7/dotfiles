local config = function()
  local ok, plugin = pcall(require, "neoclip")

  if not ok then
    return
  end

  plugin.setup()

  nmap('<leader>"', [[:Telescope neoclip<CR>]], "Neoclip")
end

local M = {
  {
    "AckslD/nvim-neoclip.lua",
    config = config,
  },
}

return M
