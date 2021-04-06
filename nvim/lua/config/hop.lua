--" Use better keys for the bépo keyboard layout and set
-- a balanced distribution of terminal / sequence keys
require'hop'.setup{
  keys = 'etovxqpdygfblzhckisuran', 
  term_seq_bias = 0.5 
}
