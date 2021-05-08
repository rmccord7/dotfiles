-- Map vim-easy-align to ga
vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})

-- Build custom alignment rules
--vim.g.easy_align_delimiters = {}

-- Alignment for c-style variable declarations
--local t = vim.g.easy_align_delimiters
local t = {}
t.d = {pattern=[[ \**\(\S\+\s*[;=]\)\@=]], left_margin=0, right_margin=0}
vim.g.easy_align_delimiters = t
--print(vim.inspect(vim.g.easy_align_delimiters))
