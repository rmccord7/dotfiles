local config = function()
  local ok, _ = pcall(require, "telescope")

  if not ok then
    return
  end

  require("telescope").load_extension("frecency")
end

local M = {
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = config,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>rw", "<cmd>Telescope frecency<cr>", desc = "Telescope frecency" },
    },
  },
}

return M
