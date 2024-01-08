M = {}

M.ignored_files = {
    -- Directories
    '%.git/.*',

    -- Clangd
    '%.cache/*',

    -- FileTypes
    '$%.ttf',
    '$%.svg',
    '$%.png',
    '$%.jpeg',
    '$%.jpg',
    '$%.ico',

    -- Files
    'tags',

    -- Output files
    '$%.o',
    '$%.a',
    '$%.lib',
    '$%.so',
    '$%.bin',
    '$%.elf',
    '$%.dblite',
    '$%.pyc',
}

function M.builtin(lhs, picker, label)
    local opts = {
        prompt_title = label,
    }
    nmap(lhs, function()
        require('telescope.builtin')[picker](opts)
    end, label)
end

function M.custom(lhs, picker, label, opts)
    local default = {
        prompt_title = label,
    }
    opts = vim.tbl_extend('keep', opts, default)
    nmap(lhs, function()
        require('telescope.builtin')[picker](opts)
    end, label)
end

function M.path_from_cwd(opts, path)

    local cwd = vim.fn.getcwd(0)
    local truncated_path

    truncated_path = path:gsub(cwd, '')
    truncated_path = require('util.path').os_path(truncated_path)

    return truncated_path
end

return M
