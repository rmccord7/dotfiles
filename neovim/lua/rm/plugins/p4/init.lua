return {
  'rmccord7/p4.nvim',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
    {
      "ColinKennedy/mega.cmdparse",
      dependencies = { "ColinKennedy/mega.logging" },
      version = "v1.*",
    },
  },
  dev = true,
  config = function(_, _)
    vim.keymap.set(
      { 'n' },
      '<leader>pc',
      [[:P4 Client display_cls<CR>]],
      { nowait = true, desc = "Open picker for the current client's CLs" }
    )

    vim.keymap.set(
      { 'n' },
      '<leader>po',
      [[:P4 opened<CR>]],
      { nowait = true, desc = "Open picker for the current client's open files" }
    )
  end,
}
