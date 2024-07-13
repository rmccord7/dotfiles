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
        event = "VeryLazy",
        config = config,
        dependencies = {
            'kyazdani42/nvim-web-devicons',
        },
    },
}

return M
