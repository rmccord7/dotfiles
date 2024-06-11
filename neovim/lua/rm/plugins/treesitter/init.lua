local config = function()

    local ok, _ = pcall(require, 'nvim-treesitter')

    if not ok then
        return
    end

    -- Prefer clang for compiling TS
    require('nvim-treesitter.install').compilers = { 'clang', 'cc' }

    -- Setup TS
    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'bash',
            'c',
            'cpp',
            'python',
            'lua',
            'yaml',
            'json',
            'markdown',
            'markdown_inline',
            'regex',
            'rust',
            'norg',
            'vim',
            'vimdoc',
        },
        sync_install = true,
        highlight = require('rm.plugins.treesitter.highlight'),
        incremental_selection = {
            enable = false,
            keymaps = {
                init_selection = '<CR>',
                node_incremental = 'CR',
                scope_incremental = '<TAB>',
                node_decremental = '<S-TAB>',
            },
        },
        indent = {
            enable = false,
        },
        textobjects = require('rm.plugins.treesitter.textobjects.config'),
    })

end

local M = {

    {
        'nvim-treesitter/nvim-treesitter',
        config = config,
        build = ':TSUpdate',
    },

    require('rm.plugins.treesitter.context'),
    require('rm.plugins.treesitter.textobjects'),
    require('rm.plugins.treesitter.rainbow-delimiters'),
}

return M