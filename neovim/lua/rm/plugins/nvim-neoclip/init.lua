local config = function()
  local ok, plugin = pcall(require, "neoclip")

  if not ok then
    return
  end

  plugin.setup()

  vim.keymap.set({"n"}, '<leader>"', [[:Telescope neoclip<CR>]], { desc = "Neoclip" })
end

local M = {
  {
    "AckslD/nvim-neoclip.lua",
    config = config,
  },
}

return M
