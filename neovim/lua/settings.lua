-- Enable TC
vim.o.termguicolors = true

-- Formatting options
vim.bo.expandtab   = true -- Expands tabs to spaces
vim.bo.smartindent = true -- Smarter indentation
vim.bo.tabstop     = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth  = 2
vim.wo.wrap        = false

--Do not save when switching buffers
vim.o.hidden = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase  = true
vim.o.inccommand = "split"

--Make line numbers default
vim.wo.number = true

--Completion options
vim.o.completeopt = "menuone,noselect"

--No highlight when searching
vim.o.hlsearch = false

--Use hybrid numbers in normal mode and
--absolute line numbers in insert mode.
vim.api.nvim_exec([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]], false)

--Show whitespace
vim.wo.list = true
vim.o.listchars = "extends:›,precedes:‹,nbsp:·,trail:·"