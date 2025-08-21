local bufnr = vim.api.nvim_get_current_buf()

if vim.b[bufnr].rm_did_ftplugin then
  return
end

vim.b[bufnr].rm_did_ftplugin = true

-- Buffer options
vim.bo.autoindent = true -- Insert indents automatically
vim.bo.expandtab = true -- Expands tabs to spaces
vim.bo.shiftwidth = 2 -- Size of an indent
vim.bo.smartindent = true -- Insert indents automatically
vim.bo.softtabstop = 2 -- Number of spaces tabs count for
vim.bo.tabstop = 2 -- Number of spaces in a tab
