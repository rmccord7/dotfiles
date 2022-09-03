vim.bo.tabstop = 3
vim.bo.softtabstop = 3
vim.bo.shiftwidth = 3
vim.bo.formatoptions= 'cqj'

-- ss1pwn
nmap('<F9>', [[:lua require('ss1pwn.comment').next_bad_comment()<CR>]], 'Next bad ss1 comment')
vmap('<F10>', [[:lua require('ss1pwn.comment').format_comment()<CR>]], 'Format bad ss1 comment')
vmap('<F11>', [[:lua require('ss1pwn.comment').format_all_comments()<CR>]], 'Format all bad ss1 comments')

-- Map to align C variable declarations by both identifier and = when visually
-- selected
xmap('<leader>ad', 'gadgvga=', 'Align c style variables')

