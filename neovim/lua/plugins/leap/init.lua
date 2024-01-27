local config = function()
    local ok, plugin = pcall(require, 'leap')

    if not ok then
        return
    end
    plugin.add_default_mappings()
    --vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
end

local M = {
    {
        'ggandor/leap.nvim',
        config = config,
    },
}

return M
