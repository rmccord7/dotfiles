local config = function()
  local ok, plugin = pcall(require, "diagflow")

  if not ok then
    return
  end

  plugin.setup()
end

local M = {
  {
    "dgagn/diagflow.nvim",
    config = config,
    event = "LspAttach",
  },
}

return M
