local config = function()
    local ok, plugin = pcall(require, 'todo-comments')

    if not ok then
        return
    end

    plugin.setup({})

    nmap('<leader>td', [[:TodoTelescope<CR>]], 'Todo Telescope')
end

local M = {
    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = config,
    },
}

return M
