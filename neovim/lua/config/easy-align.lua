-- Map vim-easy-align to ga
vim.api.nvim_set_keymap('x', '<leader>ea', '<Plug>(EasyAlign)', {})
vim.api.nvim_set_keymap('n', '<leader>ea', '<Plug>(EasyAlign)', {})

-- Alignment for c-style variable declarations
local t = {}
t.d = {pattern=[[ \**\(\S\+\s*[;=]\)\@=]], left_margin=0, right_margin=0}
vim.g.easy_align_delimiters = t
