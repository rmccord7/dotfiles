M = {}

M.ignored_files = {
    -- Directories
    '%.git/.*',

    -- Clangd
    '%.cache/*',

    -- FileTypes
    '%.ttf',
    '%.svg',
    '%.png',
    '%.jpeg',
    '%.jpg',
    '%.ico',

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
    nmap(lhs, function()
        require('telescope.builtin')[picker]()
    end, label)
end

function M.custom(lhs, picker, label, opts)
    opts = opts or {}
    nmap(lhs, function()
        require('telescope.builtin')[picker](opts)
    end, label)
end

return M
