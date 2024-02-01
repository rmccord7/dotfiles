local M = {

    -- Treesitter config
    treesitter = {
        max_size = 75 * 1024, -- Max file size
        max_lc = 75000, -- Max line count
    }
}

-- File type options
M.ft = function()

    -- Buffer options
    vim.bo.autoindent = true -- Insert indents automatically
    vim.bo.expandtab = true -- Expands tabs to spaces
    vim.bo.shiftwidth = 4 -- Size of an indent
    vim.bo.smartindent = true -- Insert indents automatically
    vim.bo.softtabstop = 4 -- Number of spaces tabs count for
    vim.bo.tabstop = 4 -- Number of spaces in a tab

end

return M
