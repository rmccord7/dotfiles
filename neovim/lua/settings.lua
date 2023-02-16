Global = require('global')

-- Enable TC
vim.o.termguicolors = true

-- Neovide
if vim.g.neovide == true then
    vim.o.guifont = 'Hack NF FC Ligatured:h10'
end

--Set python path
if Global.is_windows then
    vim.g.python3_host_prog = os_path('C:/Users/rmccord/scoop/apps/python/current/python')
else
    vim.g.python3_host_prog = '/usr/bin/python3'
end

-- Global status line
vim.o.laststatus = 3

-- Command height
vim.o.cmdheight = 0

-- Formatting options
vim.o.expandtab = true -- Expands tabs to spaces
vim.o.smartindent = true -- Smarter indentation
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.wo.wrap = false

--Do not save when switching buffers
vim.o.hidden = true

-- Search and replace options
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

--Make line numbers default
vim.wo.number = true

-- Reduced time for swap write and cursor hold event
vim.o.updatetime = 2000

--Completion options
vim.o.complete = ''
vim.o.completeopt = ''

--No highlight when searching
vim.o.hlsearch = false

--Show whitespace
vim.wo.list = true
vim.o.listchars = 'tab:››,extends:›,precedes:‹,nbsp:·,trail:·'

-- Keyword program
vim.o.keywordprg = ':vert bo help'

-- Default grep command
-- Prefer ripgrep over grep
if vim.fn.executable('rg') == 1 then
    vim.opt.grepprg = 'rg --vimgrep --smart-case'
else
    vim.opt.grepprg = 'grep -nH'
end

-- Enable exrc
vim.o.exrc = true

-- Persistent undo
vim.opt.undofile = true

-- Split window options
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = 'cursor'

-- Wildmenu
vim.opt.wildmode = { 'longest', 'list', 'full' }
vim.opt.wildmenu = true
vim.opt.wildignore = '*/node_modules/*,*/.git/*,DS_Store,*/venv/*,*/__pycache__/*,*.pyc'

-- Set file types
vim.filetype.add({
    extension = {
        h = 'c',
        scons = 'python',
        api = 'python',
    },
    filename = {
        ['.clangd'] = 'yaml',
    },
})

--Use hybrid numbers in normal mode and
--absolute line numbers in insert mode.
create_augroup('HYBRID_NUM_AUCMDS', {
    {
        events = { 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' },
        pattern = '*',
        command = 'if &nu && mode() != "i" | set rnu   | endif',
    },
    {
        events = { 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' },
        pattern = '*',
        command = 'if &nu | set nornu | endif',
    },
    {
        events = { 'TermOpen' },
        pattern = '*',
        command = 'startinsert',
    },
    {
        events = { 'TermOpen' },
        pattern = '*',
        command = ':set nonumber norelativenumber',
    },
    { events = { 'TermOpen' }, pattern = '*', command = 'nnoremap <buffer> <C-c> i<C-c>' },
})

-- Create directory on save if it doesn't exist.
create_augroup('CREATE_DIR_AUCMDS', {
    events = { 'BufWritePre' },
    pattern = '*',
    command = 'lua require("utils").create_file_directory_structure()',
})

-- Autocmds
-- highlight yank for a brief second for visual feedback
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ on_visual = false })
    end,
})

-- Disable builtin plugins i don't need
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
