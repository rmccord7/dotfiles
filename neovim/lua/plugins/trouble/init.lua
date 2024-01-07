local config = function()

    local ok, trouble = pcall(require, 'nvim-trouble')

    if not ok then
        return
    end

    trouble.setup({})
end

local M = {

    {
        'folke/lsp-trouble.nvim',
        config = config,
        dependencies = 'kyazdani42/nvim-web-devicons',
    },

}

return M

