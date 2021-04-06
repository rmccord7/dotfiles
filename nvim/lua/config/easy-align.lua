-- Map vim-easy-align to ga
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})

-- Build custom alignment rules
vim.g.easy_align_delimiters = {}

-- Alignment for c-style variable declarations
--vim.cmd([[let g:easy_align_delimiters['d'] = {'pattern': ' \**\(\S\+\s*[;=]\)\@=', 'left_margin': 0, 'right_margin': 0}]])

-- Map to align C variable declarations by both identifier and = when visually
-- selected
vim.api.nvim_set_keymap('x', '<leader>ad', 'gadgvga=', {})
