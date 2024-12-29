return {
  'sindrets/diffview.nvim',
  opts = {},
  config = function(_, opts)
    require('diffview').setup(opts)

    vim.keymap.set({ 'n' }, '<leader>do', [[:DiffviewOpen]], { nowait = true, desc = 'Diffview Open' })
    vim.keymap.set({ 'n' }, '<leader>dh', [[:DiffviewFileHistory]], { nowait = true, desc = 'Diffview File History' })
    vim.keymap.set({ 'n' }, '<leader>dc', [[:DiffviewClose<CR>]], { desc = 'Diffview Close' })
  end,
}
