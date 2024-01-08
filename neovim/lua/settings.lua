local plat = require('util.plat')
local path = require('util.path')

-- Enable TC
vim.o.termguicolors = true

-- Neovide
if vim.g.neovide == true then
    vim.o.guifont = 'Hack NF FC Ligatured:h10'
end

--Set python path
vim.g.python3_host_prog = path.python

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- global status line
vim.o.laststatus = 3

-- Command height
vim.o.cmdheight = 0

-- Avoid enter prompts for file changes
vim.opt.shortmess:append({
    --default filnxtToOF
    c = true, -- Disable "Pattern not found" messages
    m = true, -- use "[+]" instead of "[Modified]"
    r = true, -- use "[RO]" instead of "[readonly]"
    I = true, -- don't give the intro message when starting Vim |:intro|.
    S = true, -- hide search info echoing (i have a statusline for that)
    W = true, -- don't give "written" or "[w]" when writing a file
})

-- Formatting options
vim.o.expandtab = true -- Expands tabs to spaces
vim.o.smartindent = true -- Smarter indentation
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.wo.wrap = false

vim.opt.formatoptions = {
    --default jcroql
    j = true, -- remove comment leader on join comments
    c = true, -- auto wrap comments using text width, inserting the current comment leader automatically.
    r = true, -- Continue comments by default
    o = true, -- continue comment using o or O
    q = true, -- allow gq to format comments
    l = true, -- break lines that are already long?

    n = true, -- Recognize numbered lists
    a = false, -- auto-gq paragraphs
}
vim.opt.formatoptions:append('1') -- Break before 1-letter words
vim.opt.formatoptions:append('2') -- Use indent from 2nd line of a paragraph
vim.opt.fillchars = { diff = '⣿' }

-- Diffing
vim.opt.diffopt = {
    vertical = true, -- Use in vertical diff mode
    filler = true, -- blank lines to keep sides aligned
    iwhite = true, -- Ignore whitespace changes
}

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
vim.o.splitkeep = 'screen'

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
    pattern = {
        ['.*/sway/config%.d/.*'] = {'swayconfig', priority = 10},
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

create_augroup('window_group', {
    {
        events = { 'VimResized' },
        desc = 'Automatically resize windows in all tabpages when resizing Vim',
        command = 'tabdo wincmd =',
    },
    {
        events = { 'BufEnter' },
        desc = 'When :q, close if quickfix is the only window',
        callback = function()
            if vim.bo.filetype == 'qf' and vim.fn.winnr('$') < 2 then
                vim.cmd.quit()
            end
        end,

    },
    {
        events = { 'FileType' },
        pattern = 'qf',
        desc = 'Skip quickfix windows when :bprevious and :bnext',
        command = 'set nobuflisted',
    },
    {
        events = { 'QuitPre' },
        desc = 'Auto close corresponding loclist when quitting a window',
        callback = function()
            if vim.bo.filetype ~= 'qf' then
                vim.cmd('silent! lclose')
            end
        end,
        nested = true,
    }
})

-- Disable builtin plugins I don't use
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
