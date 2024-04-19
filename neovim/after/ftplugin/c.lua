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

-- Map to align C variable declarations by both identifier and = when visually
-- selected
xmap('<leader>ad', 'gadgvga=', 'Align c style variables')

-- Start LSP
if not vim.api.nvim_win_get_option(0, "diff") then

    local config = require('rm.lsp.config.clangd')

    if config then
        if vim.fn.executable(config.lsp.name) then
            vim.lsp.start(config.lsp)
        end
    end
end
