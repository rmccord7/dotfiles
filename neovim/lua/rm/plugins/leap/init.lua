return {
  'ggandor/leap.nvim',
  dependencies = {
    'tpope/vim-repeat',
  },
  config = function(_, _)
    require('leap').add_default_mappings()
  end,
}
