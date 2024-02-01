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
    vim.bo.tabstop = 3
    vim.bo.softtabstop = 3
    vim.bo.shiftwidth = 3

end

-- Map to align C variable declarations by both identifier and = when visually
-- selected
xmap('<leader>ad', 'gadgvga=', 'Align c style variables')

return M
