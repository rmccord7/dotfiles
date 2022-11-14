-- Map vim-easy-align to ga
xmap('ga', '<Plug>(EasyAlign)', 'Easy align', {})
nmap('ga', '<Plug>(EasyAlign)', 'Easy align', {})

-- Alignment for c-style variable declarations
local t = {}
t.d = {pattern=[[ \**\(\S\+\s*[;=]\)\@=]], left_margin=0, right_margin=0}
vim.g.easy_align_delimiters = t
