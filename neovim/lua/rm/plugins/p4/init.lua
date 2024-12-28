return {
  "rmccord7/p4.nvim",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-telescope/telescope.nvim",
  },
  dev = true,
  config = function(_, _)
    vim.keymap.set(
      { "n" },
      "<leader>pc",
      [[:P4 Display_CLs<CR>]],
      { nowait = true, desc = "Open picker for the current client's CLs" }
    )

    vim.keymap.set(
      { "n" },
      "<leader>po",
      [[:P4 Display_Open_Files<CR>]],
      { nowait = true, desc = "Open picker for the current client's open files" }
    )
  end,
}
