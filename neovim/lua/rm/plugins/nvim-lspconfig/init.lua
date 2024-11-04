local config = function()
    local ok, _ = pcall(require, 'lspconfig')

    if not ok then
        return
    end

    require("rm.lsp")
end

local M = {
    {
        'neovim/nvim-lspconfig',
        config = config,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
}

return M
