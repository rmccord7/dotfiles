local M = {}

-- Merge two lua tables
function M.merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

-- Automatically create missing directories before save
function M.create_file_directory_structure()
    local path = vim.fn.expand('%:p:h')

    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, 'p')
    end
end

return M
