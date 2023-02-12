local M = {

    require('plugins.editor.navigation.telescope'),

    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
            --vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
        end,
    },

    {
        'toppair/reach.nvim',
        config = function()
            require('reach').setup({})
        end,
    },
}

return M
