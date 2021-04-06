--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Map jk/kj to <esc>. Note that this causes small visual pauses when actually
--typing j or k
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true})
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', { noremap = true})

--Quick controls for cycling buffers
vim.api.nvim_set_keymap('', '<C-n>', ':bn<CR>', { noremap = false})
vim.api.nvim_set_keymap('', '<C-m>', ':bp<CR>', { noremap = false})

-- Map to remove search highlights
vim.api.nvim_set_keymap('', '<C-h>', '<C-h> :nohl<CR>', { noremap = false, silent = true})

--Remove all trailing whitespace by pressing F5
vim.api.nvim_set_keymap('n', "<F5>", [[<cmd>let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><cr>]], { noremap = true, silent = true})

--Compe
vim.api.nvim_set_keymap('i', "<C-Space>", [[compe#complete()]], {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('i', "<CR>", [[compe#confirm()]], {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('i', "<C-e>", [[compe#close('<C-e>')]], {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('i', "<C-f>", [[compe#scroll({'delta'" +4})]], {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('i', "<C-d>", [[compe#scroll({'delta'" +4})]], {noremap = true, silent = true, expr = true})

vim.api.nvim_set_keymap('i', "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap('s', "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap('i', "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap('s', "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fc', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').registers()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').treesitter()<cr>]], { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>lf', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lc', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ld', [[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lw', [[<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>]], { noremap = true, silent = true})

--Hop
vim.api.nvim_set_keymap('n', 's', [[<cmd>HopChar1<cr>]], { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tr', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
