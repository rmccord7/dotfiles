-- Formatting options
vim.o.expandtab    = true -- Expands tabs to spaces
vim.o.smartindent  = true -- Smarter indentation
vim.o.tabstop      = 4
vim.o.softtabstop  = 4
vim.o.shiftwidth   = 4
vim.o.wrap         = false

--Do not save when switching buffers
vim.o.hidden = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase  = true

--Make line numbers default
vim.wo.number = true

--Use hybrid numbers in normal mode and 
--absolute line numbers in insert mode.
vim.api.nvim_exec([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]], false)

