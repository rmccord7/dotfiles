local config = function()
    require('leap').add_default_mappings()
    --vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
end

local M = {
    {
        'ggandor/leap.nvim',
        config = config,
    },
}

return M
