local config = require('config')

-- Global options

vim.g.python3_host_prog = config.path.python_path -- Set python path

--Disable internal plugins we aren't to use
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

-- Neovim options

vim.opt.clipboard = { 'unnamedplus' } -- Use system clip board for copy/paste
vim.opt.cmdheight = 0 -- Don't show command window
vim.opt.complete = '' -- Completion
vim.opt.completeopt = '' -- Completion options
vim.opt.diffopt = { -- Diff options
    filler = true, -- Blank lines to keep sides aligned
    iwhite = true, -- Ignore whitespace changes
    vertical = true, -- Vertical diff mode
}
vim.opt.exrc = true -- Enable '.nvim.lua' project config
vim.opt.fillchars = { diff = '⣿' }
vim.opt.formatoptions = { -- Paragraph formatting options
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
vim.opt.grepprg = 'grep -nH' -- Use grep
vim.opt.guifont = { 'Hack NF FC Ligatured:h10' } -- Set GUI font
vim.opt.hidden = true --Do not save when switching buffers
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.laststatus = 3 -- Display status line across all windows
vim.opt.inccommand = 'split' -- Show partial search/replace results in a preview
vim.opt.hlsearch = false -- No highlighting when searching
vim.opt.keywordprg = ':vert bo help' -- Open help in vertical split
vim.opt.listchars = { -- Strings to use in list mode
    tab = '››', -- Character to show for tab
    extends = '›', -- Character to show when wrap is off an line extends beyond the screen
    precedes = '‹', -- Character to show when there is text preceding the first visible character
    nbsp = '·', -- Character to show for a non breakable space character
    trail = '·', -- Trailing spaces
}
vim.opt.shortmess:append({ -- Avoid enter prompts for file messages
    --default filnxtToOF
    c = true, -- Disable "Pattern not found" messages
    m = true, -- Use "[+]" instead of "[Modified]"
    r = true, -- Use "[RO]" instead of "[readonly]"
    I = true, -- Don't give the intro message when starting Vim |:intro|.
    S = true, -- Hide search info echoing
    W = true, -- Don't give "written" or "[w]" when writing a file
})
vim.opt.smartcase = true -- Overide ignore case if capital letter in search
vim.opt.splitright = true -- Split window right by default
vim.opt.splitbelow = true -- Split window bottom by default
vim.opt.splitkeep = 'screen' -- Keep text the same when opening, closing, or resizing splits
vim.opt.termguicolors = true -- Enable true color
vim.opt.undodir = config.path.nvim_data .. "/undos" -- Set the undo directory
vim.opt.undofile = true -- Enable undo between neovim sessions
vim.opt.updatetime = 2000 -- Time (ms) for swap write and cursor hold event
vim.opt.wildmode = { 'list', 'longest',  } -- Command line completion mode
vim.opt.wildignore = { -- Ignore these files and folders for command line completion
    '*/node_modules/*',
    '*/.git/*',
    'DS_Store',
    '*/venv/*',
    '*/__pycache__/*',
    '*.pyc'
}

-- Buffer options

vim.bo.autoindent = true -- Insert indents automatically
vim.bo.expandtab = true -- Expands tabs to spaces
vim.bo.shiftwidth = 4 -- Size of an indent
vim.bo.smartindent = true -- Insert indents automatically
vim.bo.softtabstop = 4 -- Number of spaces tabs count for
vim.bo.tabstop = 4 -- Number of spaces in a tab

-- Window options

vim.wo.list = true -- Show whitespace characters like tabs and spaces
vim.wo.number = true  -- Show line numbers
vim.wo.wrap = false -- Do not display text over multiple lines

-- External options

-- Use Rip grep instead of grep if supported
if config.apps.rg then
    vim.opt.grepprg = 'rg --vimgrep --smart-case' -- Use rg instead of grep
end
