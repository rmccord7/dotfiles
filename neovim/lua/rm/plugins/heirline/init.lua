return {
  'rebelot/heirline.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'kyazdani42/nvim-web-devicons',
  },
  event = 'VeryLazy',
  config = function(_, _)
    local opts = {
      statusline = require('rm.plugins.heirline.statusline'),
    }

    require('heirline').setup(opts)
  end,
}
