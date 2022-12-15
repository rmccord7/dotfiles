local ok, tree = pcall(require, 'nvim-tree')

if not ok then
    return
end

vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
}

vim.g.nvim_tree_icons = {
    default = '',
    git = {
        unstaged = '✗',
        staged = '✓',
        unmerged = '',
        renamed = '➜',
        untracked = '?',
    },
    folder = {
        default = '',
        open = '',
    },
}

tree.setup({
    sync_root_with_cwd = true,
    filters = {
        custom = {
            '.git',
            'out',
            'dist',
        },
    },
})
