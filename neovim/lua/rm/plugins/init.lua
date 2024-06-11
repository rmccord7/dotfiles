return {
    require('rm.plugins.comment'),
    require('rm.plugins.diagflow'),
    require('rm.plugins.diffview'),
    require('rm.plugins.gitsigns'),
    require('rm.plugins.heirline'),
    require('rm.plugins.indent-blankline'),
    require('rm.plugins.lazydev'),
    require('rm.plugins.lsp-inlayhints'),
    require('rm.plugins.luasnip'),
    require('rm.plugins.markdown-preview'),
    require('rm.plugins.mason'),
    require('rm.plugins.material'),
    require('rm.plugins.noice'),
    require('rm.plugins.nvim-autopairs'),
    require('rm.plugins.nvim-cmp'),
    require('rm.plugins.nvim-colorizer'),
    require('rm.plugins.nvim-luaref'),
    require('rm.plugins.nvim-neoclip'),
    require('rm.plugins.nvim-surround'),
    require('rm.plugins.nvim-tree'),
    require('rm.plugins.p4'),
    require('rm.plugins.project'),
    require('rm.plugins.reach'),
    require('rm.plugins.ss1pwn'),
    require('rm.plugins.telescope'),
    require('rm.plugins.todo-comments'),
    require('rm.plugins.treesitter'),
    require('rm.plugins.trouble'),
    require('rm.plugins.vim-abolish'),
    require('rm.plugins.vim-easy-align'),
    require('rm.plugins.which-key'),

    {
        'elkowar/yuck.vim',
    },

    {
        "theRealCarneiro/hyprland-vim-syntax",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = "hypr",
    },
}
