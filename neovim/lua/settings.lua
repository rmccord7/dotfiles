Utils = require('utils')
Global = require('global')

-- Enable TC
vim.o.termguicolors = true

-- Neovide
if vim.g.neovide == true then
  vim.o.guifont = 'Hack NF FC Ligatured:h09'
end

--Set python path
if Global.is_windows == true then
  vim.g.python3_host_prog = 'C:\\Users\\rmccord\\scoop\\apps\\python\\current\\python'
else
  vim.g.python3_host_prog = '/usr/bin/python'
end

-- Status
vim.o.laststatus = 3

-- Formatting options
vim.o.expandtab   = true -- Expands tabs to spaces
vim.o.smartindent = true -- Smarter indentation
vim.o.tabstop     = 2
vim.o.softtabstop = 2
vim.o.shiftwidth  = 2
vim.wo.wrap       = false

--Do not save when switching buffers
vim.o.hidden = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase  = true
vim.o.inccommand = "split"

--Make line numbers default
vim.wo.number = true

--Completion options
vim.o.completeopt = "menu,menuone,noselect"

--No highlight when searching
vim.o.hlsearch = false

--Show whitespace
vim.wo.list = true
vim.o.listchars = "tab:››,extends:›,precedes:‹,nbsp:·,trail:·"

-- Default grep command
-- Prefer ripgrep over grep
if vim.fn.executable('rg') == 1 then
    vim.opt.grepprg = 'rg --vimgrep --smart-case'
else
    vim.opt.grepprg = 'grep -nH'
end

-- Folding (with Treesitter)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').]] ..
                   [[' ... '.trim(getline(v:foldend)).]] ..
                   [[' ('.(v:foldend-v:foldstart).' lines folded...)']]
vim.opt.fillchars = "fold: "
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 4

-- Persistent undo
vim.opt.undofile = true

-- Auto read file changes
vim.opt.autoread = true

-- Wildmenu
vim.opt.wildmode = {'longest', 'list', 'full'}
vim.opt.wildmenu = true

--Use hybrid numbers in normal mode and
--absolute line numbers in insert mode.
Utils.create_augroup(
  'HYBRID_NUM_AUCMDS',
  {
    { {'BufEnter','FocusGained','InsertLeave', 'WinEnter'}, {'*'}, 'if &nu && mode() != "i" | set rnu   | endif' },
    { {'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave'}, {'*'}, 'if &nu | set nornu | endif' },
    { {'TermOpen'}, {'*'}, 'startinsert' },
    { {'TermOpen'}, {'*'}, ':set nonumber norelativenumber' },
    { {'TermOpen'}, {'*'}, 'nnoremap <buffer> <C-c> i<C-c>' }
  }
)

-- Create directory on save if it doesn't exist.
Utils.create_augroup(
  'CREATE_DIR_AUCMDS',
  {
    { {'BufWritePre'}, {'*'}, 'lua require("utils").create_file_directory_structure()' }
  }
)

