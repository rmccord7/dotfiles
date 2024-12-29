return {
  'AckslD/nvim-neoclip.lua',
  opts = {},
  config = function(_, opts)
    require('neoclip').setup(opts)

    vim.keymap.set({ 'n' }, '<leader>"', [[:Telescope neoclip<CR>]], { desc = 'Neoclip' })
  end,
}
