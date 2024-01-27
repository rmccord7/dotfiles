local config = function()
    local ok, plugin = pcall(require, 'ibl')

    if not ok then
        return
    end
    -- local colors = require('material').colors

    plugin.setup({

        -- config = {
            --     scope = {
                --         highlight = colors.editor.border
                --     }
                -- }
            })
end

local M = {
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        config = config,
    },
}

return M
