-- Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Map jk/kj to <esc>. Note that this causes small visual pauses when actually
-- typing j or k
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true})
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', { noremap = true})

-- Reselect last put text
vim.api.nvim_set_keymap('n', 'gV', '\'[v\']', { noremap = true})

-- Map to remove search highlights
--vim.api.nvim_set_keymap('', '<leader>h', '<C-h> :nohl<CR>', { noremap = false, silent = true})

-- Remove all trailing whitespace by pressing F5
vim.api.nvim_set_keymap('n', "<F5>", [[<cmd>let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><cr>]], { noremap = true, silent = true})

-- Compe
vim.api.nvim_set_keymap('i', "<C-Space>", [[compe#complete()]], {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('i', "<CR>", [[compe#confirm()]], {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap('i', "<C-e>", [[compe#close('<C-e>')]], {noremap = true, silent = true, expr = true})
--vim.api.nvim_set_keymap('i', "<C-f>", [[compe#scroll({'delta'" +4})]], {noremap = true, silent = true, expr = true})
--vim.api.nvim_set_keymap('i', "<C-d>", [[compe#scroll({'delta'" +4})]], {noremap = true, silent = true, expr = true})

vim.api.nvim_set_keymap('i', "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap('s', "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap('i', "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap('s', "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>bf', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').registers()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>tf', [[<cmd>lua require('telescope.builtin').treesitter()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fc', [[<cmd>lua require('telescope.builtin').command_history()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').search_history()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lc', [[<cmd>lua require('telescope.builtin').commands()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fq', [[<cmd>lua require('telescope.builtin').quickfix()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fl', [[<cmd>lua require('telescope.builtin').loclist()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fk', [[<cmd>lua require('telescope.builtin').keymaps()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fm', [[<cmd>lua require('telescope.builtin').marks()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fd', [[<cmd>Telescope dotfiles path='..os.getenv("HOME")..'/.dotfiles<cr>]], { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>lf', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lc', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ld', [[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>lw', [[<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>]], { noremap = true, silent = true})

-- Hop
--vim.api.nvim_set_keymap('n', 's', [[<cmd>HopChar2<cr>]], { noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', 'S', [[<cmd>HopLine<cr>]], { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tr', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })

-- Map to align C variable declarations by both identifier and = when visually
-- selected
vim.api.nvim_set_keymap('x', '<leader>ad', 'gadgvga=', {})

-- VSnip
vim.api.nvim_set_keymap("i" , "<C-l>" , "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'" , { noremap = false , expr = true })
vim.api.nvim_set_keymap("s" , "<C-l>" , "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'" , { noremap = false , expr = true })

-- BarBar
--    Move to previous/next
vim.api.nvim_set_keymap('n', '<A-,>', ':BufferPrevious<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-.>', ':BufferNext<CR>', { noremap = true, silent = true})

--    Re-order to previous/next
vim.api.nvim_set_keymap('n', '<A-<>', ':BufferMovePrevious<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A->>', ':BufferMoveNext<CR>', { noremap = true, silent = true})

--    Goto buffer in position
vim.api.nvim_set_keymap('n', '<A-1>', ':BufferGoto 1<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-2>', ':BufferGoto 2<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-3>', ':BufferGoto 3<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-4>', ':BufferGoto 4<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-5>', ':BufferGoto 5<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-6>', ':BufferGoto 6<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-7>', ':BufferGoto 7<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-8>', ':BufferGoto 8<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-9>', ':BufferLast 9<CR>', { noremap = true, silent = true})

--    Close buffer
vim.api.nvim_set_keymap('n', '<A-c>', ':BufferClose<CR>', { noremap = true, silent = true})

-- Magic buffer-picking mode
vim.api.nvim_set_keymap('n', '<C-s>', ':BufferPick<CR>', { noremap = true, silent = true})

-- Miniyank
vim.api.nvim_set_keymap('', 'p', '<Plug>(miniyank-autoput)', {})
vim.api.nvim_set_keymap('', 'P', '<Plug>(miniyank-autoPut)', {})

vim.api.nvim_set_keymap('', '<leader>n', '<Plug>(miniyank-cycle)', {})
vim.api.nvim_set_keymap('', '<leader>N', '<Plug>(miniyank-cycleback)', {})

--LSP trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>LspTroubleToggle<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>LspTroubleToggle lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>LspTroubleToggle lsp_document_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>LspTroubleToggle loclist<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>LspTroubleToggle quickfix<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>LspTrouble lsp_references<cr>", {silent = true, noremap = true})

--Lightspeed
function repeat_ft(reverse)
  local ls = require'lightspeed'
  ls.ft['instant-repeat?'] = true
  ls.ft:to(reverse, ls.ft['prev-t-like?'])
end
vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>',
		    {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>',
		    {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>',
		    {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>',
		    {noremap = true, silent = true})

vim.api.nvim_exec(
[[
let g:sandwich_no_default_key_mappings = 1
silent! nmap <unique><silent> <leader>sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
silent! nmap <unique><silent> <leader>sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
silent! nmap <unique><silent> <leader>sdb <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
silent! nmap <unique><silent> <leader>srb <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

let g:operator_sandwich_no_default_key_mappings = 1
silent! map <unique> <leader>sa <Plug>(operator-sandwich-add)
silent! xmap <unique> <leader>sd <Plug>(operator-sandwich-delete)
silent! xmap <unique> <leader>sr <Plug>(operator-sandwich-replace)
]],
false)
