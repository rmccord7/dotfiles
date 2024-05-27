-- Start LSP
local config = require('rm.lsp.config.lua_ls')

if config then
    if vim.fn.executable(config.lsp.name) then
        vim.lsp.start(config.lsp)
    end
end

local bufnr = vim.api.nvim_get_current_buf()

if vim.b[bufnr].rm_did_ftplugin then
  return
end

vim.b[bufnr].rm_did_ftplugin = true

-- Buffer options
vim.bo.autoindent = true -- Insert indents automatically
vim.bo.expandtab = true -- Expands tabs to spaces
vim.bo.shiftwidth = 4 -- Size of an indent
vim.bo.smartindent = true -- Insert indents automatically
vim.bo.softtabstop = 4 -- Number of spaces tabs count for
vim.bo.tabstop = 4 -- Number of spaces in a tab

