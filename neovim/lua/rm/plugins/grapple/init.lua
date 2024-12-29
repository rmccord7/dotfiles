return {
  {
    'cbochs/grapple.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = 'Grapple',
    opts = {
      scope = 'lsp',
    },
    keys = {
      { '<leader>a', '<cmd>Grapple toggle<cr>', desc = 'Tag a file' },
      { '<c-e>', '<cmd>Grapple toggle_tags<cr>', desc = 'Toggle tags menu' },

      { '<c-h>', '<cmd>Grapple select index=1<cr>', desc = 'Select first tag' },
      { '<c-t>', '<cmd>Grapple select index=2<cr>', desc = 'Select second tag' },
      { '<c-n>', '<cmd>Grapple select index=3<cr>', desc = 'Select third tag' },
      { '<c-s>', '<cmd>Grapple select index=4<cr>', desc = 'Select fourth tag' },

      { '<c-s-n>', '<cmd>Grapple cycle_tags next<cr>', desc = 'Go to next tag' },
      { '<c-s-p>', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Go to previous tag' },

      -- { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
      -- { "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
      -- { "<leader>n", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
      -- { "<leader>p", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
    },
  },
}
