local global = require('global')

-- Remap space as leader key
--map('', '<Space>', '<Nop>', 'Leader')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Ex-mode is weird and not useful so it seems better to repeat the last macro
nmap('Q', '@@', 'Repeat last macro')

-- Map jk/kj to <esc>. Note that this causes small visual pauses when actually
-- typing j or k
imap('jk', '<ESC>', 'Exit insert mode')
imap('kj', '<ESC>', 'Exit insert mode')

-- Keep cursor centered on search, motions, and join.
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')
nmap('g;', 'g;zz')
nmap('gi', 'zzgi')
nmap('J', "mzJ'z")
nmap('[c', '[czz')
nmap(']c', ']czz')
nmap('<C-u>', '<C-u>zz')
nmap('<C-d>', '<C-d>zz')
nmap('<C-f>', '<C-f>zz')
nmap('<C-b>', '<C-b>zz')

-- Don't undo everything.
imap('.', '.<c-g>u')
imap(',', ',<c-g>u')
imap('!', '!<c-g>u')
imap('?', '?<c-g>u')

-- Return from relative number jumping.
nmap('j', [[(v:count > 5 ? "m'" . v:count : "") . 'j']], 'Move line down', { expr = true })
nmap('k', [[(v:count > 5 ? "m'" . v:count : "") . 'k']], 'Move line up', { expr = true })

--Moving text
vmap('J', [[:m '>+1<CR>gv=gv]], 'Move text down')
vmap('K', [[:m '<-2<CR>gv=gv]], 'Move text up')
imap('<C-j>', [[<esc>:m .+1<CR>==]], 'Move text up')
imap('<C-k>', [[<esc>:m .-2<CR>==]], 'Move text down')
nmap('<leader>k', [[:m .-2<CR>==]], 'Move line up')
nmap('<leader>j', [[:m .+1<CR>==]], 'Move line down')

-- make c/C change command send text to black hole register, i didn't want
-- it anyways if I changed it probably
nmap('c', '"_c')
nmap('C', '"_C')

-- Change word. Set next word for quick search/replace..
nmap('cn', [[*''cgn]], 'Change next word')
nmap('cN', [[*''cgN]], 'Change next word')

-- Reselect last put text
nmap('gV', "'[v']", 'Select last put text')

-- Replace currently selected text with default register without yanking it
vmap('p', '"_dP', nil, { silent = false })

-- Insert new line without leaving normal mode.
nmap('<leader>o', [[:<C-u>call append(line("."), repeat([""], v:count1))<CR>]], 'Insert new line below')
nmap('<leader>O', [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]], 'Insert new line above')

-- run a :command
nmap('go', ':', 'Command-line mode', { silent = false })
vmap('go', ':', 'Command-line mode', { silent = false })

-- Substitute Linewise
nmap('<leader>sl', ':s/', 'Linewise search', { silent = false })
vmap('<leader>sl', ':s/', 'Linewise search', { silent = false })

-- Substitute Globally
nmap('<leader>sg', ':%s/', 'Global buffer search', { silent = false })
vmap('<leader>sg', ':%s/', 'Global buffer search', { silent = false })

-- swap to alternate file
--nmap('ga', '<c-^>', 'Swap to alt file', {silent = false})
--vmap('ga', '<c-^>', 'Swap to alt file', {silent = false})

-- repeat last macro
nmap('<c-m>', '@@', 'Repeat last macro', { silent = false })
vmap('<c-m>', '@@', 'Repeat last macro', { silent = false })

-- repeat last :command
nmap('gx', '@:', 'Repeat last command', { silent = false })
vmap('gx', '@:', 'Repeat last command', { silent = false })

-- remap q: to be easier to use, less work for your poor left pinky
nmap('<c-q>', 'q:', 'Open cmdline window', { silent = false })
vmap('<c-q>', 'q:', 'Open cmdline window', { silent = false })

-- quickfix list navigation yay
nmap('<leader>qo', '<cmd>copen<cr>', 'Open qflist')
nmap('<leader>qn', '<cmd>cnext<cr>', 'Next item in qf list')
nmap('<leader>qp', '<cmd>cprev<cr>', 'Prev item in qf list')
nmap('<leader>qd', function()
    vim.ui.input({ prompt = 'Quickfix do: ', completion = 'command' }, function(do_cmd)
        if do_cmd then
            vim.cmd('cfdo ' .. do_cmd)
        end
    end)
end, 'Exec cmd for all items in qf list')

-- take the only existing window and split it to the right
nmap('<leader>wr', [[<cmd>vnew | wincmd r | wincmd l<cr>]], 'Split 1 window to right')

-- swap windows and move cursor to other window
nmap('<leader>wl', [[<cmd>wincmd r | wincmd l<cr>]], 'Swap windows and move cursor')

-- Lazy home
nmap('<leader>lh', [[:Lazy home<CR>]], 'Lazy home')

-- Nvim Tree
nmap('<leader>tt', [[:NvimTreeToggle<CR>]], 'Nvim tree toggle')
nmap('<leader>tf', [[:NvimTreeFindFile<CR>]], 'Nvim tree find file')

-- Diffview
nmap('<leader>gd', [[:DiffviewOpen]], 'Diffview Open', {nowait = true})
nmap('<leader>gh', [[:DiffviewFileHistory]], 'Diffview File History', {nowait = true})
nmap('<leader>gx', [[:DiffviewClose<CR>]], 'Diffview Close')

-- ToDo
nmap('<leader>td', [[:TodoTelescope<CR>]], 'Todo Telescope')

-- LSP Sage Symbols outline
nmap('<leader>so', [[:Lspsaga outline<CR>]], 'Symbols outline')

-- Neoclip
nmap('<leader>"', [[:Telescope neoclip<CR>]], 'Neoclip')

-- Treesitter text objects
nmap(']m', [[:TSTextobjectGotoNextStart @function.outer<CR>zz]], 'Go to next function start')
nmap(']M', [[:TSTextobjectGotoNextEnd @function.outer<CR>zz]], 'Go to next function end')
nmap('[m', [[:TSTextobjectGotoPreviousStart @function.outer<CR>zz]], 'Go to previous function start')
nmap('[M', [[:TSTextobjectGotoPreviousEnd @function.outer<CR>zz]], 'Go to previous function end')

-- Miniyank
map('', 'p', '<Plug>(miniyank-autoput)', 'Override put for miniyank')
map('', 'P', '<Plug>(miniyank-autoPut)', 'Override put for miniyank')

map('', '<leader>p', '<Plug>(miniyank-cycle)', 'Miniyank cycle next')
map('', '<leader>P', '<Plug>(miniyank-cycleback)', 'Miniyank cycle previous')

--LSP trouble
nmap('<leader>xx', ':Trouble<CR>', 'Trouble toggle')
nmap('<leader>xw', ':Trouble workspace_diagnostics<CR>', 'Trouble workspace diagnostics')
nmap('<leader>xd', ':Trouble document_diagnostics<CR>', 'Trouble document diagnostics')
nmap('<leader>xq', ':Trouble quickfix<CR>', 'Trouble quickfix')
nmap('<leader>xl', ':Trouble loclist<CR>', 'Trouble loclist')
nmap('<leader>xr', ':Trouble lsp_references<CR>', 'Trouble LSP Ref')
nmap('<leader>xn', [[:lua require('trouble').next({skip_groups = false, jump = true})<CR>]], 'Trouble Next')
nmap('<leader>xp', [[:lua require('trouble').previous({skip_groups = false, jump = true})<CR>]], 'Trouble Previous')

-- Reach
nmap('<leader>b', ':ReachOpen buffers<CR>', 'Reach Open Buffers')
nmap("<leader>'", ':ReachOpen marks<CR>', 'Reach Open Marks')

-- Toggle relative line numbers
nmap('<leader>tn', function()
    if vim.api.nvim_win_get_option(0, 'relativenumber') then
        vim.cmd 'windo set norelativenumber'
    else
        vim.cmd 'windo set relativenumber'
    end
end, 'Toogle relative line numbers')

-- Reload current buffer if it is a vim or lua file (Source Here)
nmap('<leader>sh', function()
    local ft = vim.api.nvim_buf_get_option(0, 'filetype')
    if ft == 'vim' then
        vim.cmd('source %')
        vim.notify('vim file reloaded!', vim.log.levels.INFO)
    elseif ft == 'lua' then
        vim.cmd('luafile %')
        vim.notify('lua file reloaded!', vim.log.levels.INFO)
    else
        vim.notify('Not a lua or vim file', vim.log.levels.INFO)
    end
end, 'Source Here (reload current file)')

-- Search dev docs
nmap('<leader>dd', function()
    local query = vim.fn.input({ default = 'Search DevDocs: ' })
    local encodedURL = nil

    if global.os_open_cmd ~= '' then
        encodedURL = global.os_open_cmd .. string.format(' "https://devdocs.io/#q=%s"', query:gsub('%s', '%%20'))

        os.execute(encodedURL)
    else
        vim.notify('Open command not supported by OS', vim.log.levels.ERROR)
    end
end, 'Search DevDocs')

-- Change a split between horizontal and vertical
nmap('<leader>ws', function()
    local a = vim.api
    local windows = a.nvim_tabpage_list_wins(0)

    if #windows ~= 2 then
        vim.notify('Only works for 2 splits', vim.log.levels.ERROR)
        return
    end

    local ui = a.nvim_list_uis()[1]
    local win1_height = a.nvim_win_get_height(windows[1])
    local win2_height = a.nvim_win_get_height(windows[2])

    local cmd_mapping
    if ui.height < win1_height + win2_height then
        cmd_mapping = a.nvim_replace_termcodes('<c-w>K', true, false, true)
    else
        cmd_mapping = a.nvim_replace_termcodes('<c-w>L', true, false, true)
    end

    if cmd_mapping then
        a.nvim_feedkeys(cmd_mapping, 'n', false)
    end
end, 'Swap split between horizontal and vertical')

-- Turn terminal to normal mode with escape if it's not a lazygit terminal
create_augroup('REMAP_TERM_ESCAPE_UNLESS_LAZYGIT', {
    events = 'TermOpen',
    pattern = '*',
    callback = function()
        if vim.fn.expand('%:t', false) ~= 'lazygit' then
            tmap('<esc>', [[<c-\><c-n>]], 'Escape term')
        end
    end,
})
