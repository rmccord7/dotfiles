local config = function()
    require('which-key').setup()
end

local M = {
    {
        'folke/which-key.nvim',
        config = config,
    },
}

return M
