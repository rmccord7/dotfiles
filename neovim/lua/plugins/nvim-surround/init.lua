local config = function()
    local ok, plugin = pcall(require, 'nvim-autopairs')

    if not ok then
        return
    end

    plugin.setup()
end

local M = {
    {
        'windwp/nvim-autopairs',
        config = config,
    },
}

return M
