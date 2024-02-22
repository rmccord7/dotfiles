local config = function()
    local ok, plugin = pcall(require, 'which-key')

    if not ok then
        return
    end

    plugin.setup()
end

local M = {
    {
        'folke/which-key.nvim',
        config = config,
    },
}

return M
