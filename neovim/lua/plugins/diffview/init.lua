local config = function()
    require('diffview').setup()
end

local M = {
    {
        'sindrets/diffview.nvim',
        config = config,
    },
}

return M
