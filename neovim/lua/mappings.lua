local map = require('utils').map

-- Remap space as leader key
map('', '<Space>', '<Nop>')
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Packer
map('n', '<leader>ps', [[<cmd>PackerSync<CR>]], {silent = true})

-- Use float winoow for ex mode
map("n", ":", [[<cmd>lua require('fine-cmdline').open()<CR>]], {silent = true})

-- Ex-mode is weird and not useful so it seems better to repeat the last macro
map('n', 'Q', '@@')

-- Map jk/kj to <esc>. Note that this causes small visual pauses when actually
-- typing j or k
map('i', 'jk', '<ESC>')
map('i', 'kj', '<ESC>')

-- Keep cursor centered on search, motions, and join.
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ\'z')
map('n', '[c', '[czz')
map('n', ']c', ']czz')
map('n', '[m', '[mzz')
map('n', ']m', ']mzz')

-- Don't undo everything.
map('i', '.', '.<c-g>u')
map('i', ',', ',<c-g>u')
map('i', '!', '!<c-g>u')
map('i', '?', '?<c-g>u')

-- Return from relative number jumping.
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : "") . 'j']], {expr = true})
map('n', 'k', [[(v:count > 5 ? "m'" . v:count : "") . 'k']], {expr = true})

--Moving text
map('v', 'J', [[:m '>+1<CR>gv=gv]])
map('v', 'K', [[:m '<-2<CR>gv=gv]])
map('i', '<C-j>', [[<esc>:m .+1<CR>==]])
map('i', '<C-k>', [[<esc>:m .-2<CR>==]])
map('n', '<leader>k', [[:m .-2<CR>==]])
map('n', '<leader>j', [[:m .+1<CR>==]])

-- Change word. Set next word for quick search/replace..
map('n', 'cn', [[*''cgn]])
map('n', 'cN', [[*''cgN]])

-- Reselect last put text
map('n', 'gV', '\'[v\']')

-- Insert new line without leaving normal mode.
map('n', '<leader>o', [[:<C-u>call append(line("."), repeat([""], v:count1))<CR>]])
map('n', '<leader>O', [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]])

-- Map to remove search highlights
--map('', '<leader>h', '<C-h> :nohl<CR>', {silent = true})

-- Remove all trailing whitespace by pressing F5
--map('n', "<F5>", [[<cmd>let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]], {silent = true})

-- ss1pwn
map('n', '<F9>', [[<cmd>lua require('ss1pwn.comment').next_bad_comment()<CR>]], {silent = true})
map('v', '<F10>', [[<cmd>lua require('ss1pwn.comment').format_comment()<CR>]], {silent = true})
map('v', '<F11>', [[<cmd>lua require('ss1pwn.comment').format_all_comments()<CR>]], {silent = true})

-- Telescope
map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], {silent = true})
map('n', '<leader>lb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], {silent = true})
map('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], {silent = true})
map('n', '<leader>bf', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], {silent = true})
map('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], {silent = true})
map('n', '<leader>fr', [[<cmd>lua require('telescope.builtin').registers()<CR>]], {silent = true})
map('n', '<leader>tf', [[<cmd>lua require('telescope.builtin').treesitter()<CR>]], {silent = true})
map('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').command_history()<CR>]], {silent = true})
map('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').search_history()<CR>]], {silent = true})
map('n', '<leader>fc', [[<cmd>lua require('telescope.builtin').commands()<CR>]], {silent = true})
map('n', '<leader>fq', [[<cmd>lua require('telescope.builtin').quickfix()<CR>]], {silent = true})
map('n', '<leader>fl', [[<cmd>lua require('telescope.builtin').loclist()<CR>]], {silent = true})
map('n', '<leader>fk', [[<cmd>lua require('telescope.builtin').keymaps()<CR>]], {silent = true})
map('n', '<leader>fm', [[<cmd>lua require('telescope.builtin').marks()<CR>]], {silent = true})
map('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], {silent = true})
map('n', '<leader>fd', [[<cmd>Telescope dotfiles path='..os.getenv("HOME")..'/.dotfiles<CR>]], {silent = true})

map('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]], {silent = true})
map('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]], {silent = true})
map('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]], {silent = true})
map('n', '<leader>gp', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]], {silent = true})

map('n', '<leader>lf', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]], {silent = true})
map('n', '<leader>lc', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], {silent = true})
map('n', '<leader>lr', [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]], {silent = true})
map('n', '<leader>ld', [[<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>]], {silent = true})
map('n', '<leader>lw', [[<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>]], {silent = true})

map('n', '<leader>ls', [[<cmd>SearchSession<CR>]], {silent = true})

-- Symbol Outline
map('n', '<leader>so', [[<cmd>SymbolsOutline<CR>]], {silent = true})

-- Neoclip
map('n', '<leader>"', [[<cmd>Telescope neoclip<CR>]], {silent = true})

-- Treesitter text objects
map('n', ']m', [[<cmd>TSTextobjectGotoNextStart @function.outer<CR>zz]], {silent = true})
map('n', ']M', [[<cmd>TSTextobjectGotoNextEnd @function.outer<CR>zz]], {silent = true})
map('n', '[m', [[<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>zz]], {silent = true})
map('n', '[M', [[<cmd>TSTextobjectGotoPreviousEnd @function.outer<CR>zz]], {silent = true})

-- Nvim Tree
map('n', '<leader>t', ':NvimTreeToggle<CR>', {silent = true})
map('n', '<leader>tr', ':NvimTreeRefresh<CR>', {silent = true })

-- Map to align C variable declarations by both identifier and = when visually
-- selected
map('x', '<leader>ad', 'gadgvga=')

-- VSnip
map('i' , '<C-l>' , "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'" , {expr = true })
map('s' , '<C-l>' , "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'" , {expr = true })

-- Miniyank
map('', 'p', '<Plug>(miniyank-autoput)', {noremap = false})
map('', 'P', '<Plug>(miniyank-autoPut)', {noremap = false})

map('', '<leader>p', '<Plug>(miniyank-cycle)', {noremap = false})
map('', '<leader>P', '<Plug>(miniyank-cycleback)', {noremap = false})

--LSP trouble
map("n", "<leader>xx", "<cmd>LspTroubleToggle<CR>", {silent = true})
map("n", "<leader>xw", "<cmd>LspTroubleToggle lsp_workspace_diagnostics<CR>", {silent = true})
map("n", "<leader>xd", "<cmd>LspTroubleToggle lsp_document_diagnostics<CR>", {silent = true})
map("n", "<leader>xl", "<cmd>LspTroubleToggle loclist<CR>", {silent = true})
map("n", "<leader>xq", "<cmd>LspTroubleToggle quickfix<CR>", {silent = true})
map("n", "gR", "<cmd>LspTrouble lsp_references<CR>", {silent = true})

-- Harpoon
map('n', '<leader>je', [[<cmd>lua require'harpoon.mark'.add_file()<CR>]], {silent = true})
map('n', '<leader>jr', [[<cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>]], {silent = true})

map('n', '<leader>ja', [[<cmd>lua require'harpoon.ui'.nav_file(1)<CR>]], {silent = true})
map('n', '<leader>js', [[<cmd>lua require'harpoon.ui'.nav_file(2)<CR>]], {silent = true})
map('n', '<leader>jd', [[<cmd>lua require'harpoon.ui'.nav_file(3)<CR>]], {silent = true})
map('n', '<leader>jf', [[<cmd>lua require'harpoon.ui'.nav_file(4)<CR>]], {silent = true})

map('n', '<leader>ju', [[<cmd>lua require'harpoon.term'.gotoTerminal(2)<CR>]], {silent = true})
map('n', '<leader>jl', [[<cmd>lua require'harpoon.term'.gotoTerminal(1)<CR>]], {silent = true})

-- Sandwich
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
