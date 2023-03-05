local config = function()
    require('nvim-web-devicons').setup({})

    local ok, heirline = pcall(require, 'heirline')

    if not ok then
        return
    end

    heirline.setup({
        statusline = require('plugins.ui.heirline.statusline'),
    })
end

local M = {
    {
        'rebelot/heirline.nvim',
        event = 'VeryLazy',
        config = config,
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'kyazdani42/nvim-web-devicons',
        },
    },
}

return M
