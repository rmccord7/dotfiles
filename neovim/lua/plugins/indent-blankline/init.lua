local config = function()
    -- local colors = require('material').colors

    require('ibl').setup({

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
