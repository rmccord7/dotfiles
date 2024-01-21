local config = function()
    require('lspsaga').setup({
        outline = {
            win_position = "left",
        },
    })

    nmap('<leader>so', [[:Lspsaga outline<CR>]], 'Symbols outline')
end

local M = {
    {
        'glepnir/lspsaga.nvim',
        opt = true,
        event = "BufRead",
        branch = 'main',
        config = config,
    },
}

return M
