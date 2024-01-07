local config = function()
    require('nvim-autopairs').setup()
end

local M = {
    {
        'windwp/nvim-autopairs',
        config = config,
    },
}

return M
