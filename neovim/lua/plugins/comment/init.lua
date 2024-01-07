local config = function()
    require('Comment').setup()
end

local M = {
    {
        'numToStr/Comment.nvim',
        config = config,
    },
}

return M
