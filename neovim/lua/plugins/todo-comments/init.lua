local config = function()
    require('todo-comments').setup({})

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
