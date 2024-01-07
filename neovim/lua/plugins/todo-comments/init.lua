local config = function()
    require('todo-comments').setup({})
end

local M = {
    {
        'folke/todo-comments.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = config,
    },
}

return M
