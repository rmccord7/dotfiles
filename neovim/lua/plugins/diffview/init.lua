local config = function()
    require('diffview').setup()

    nmap('<leader>gd', [[:DiffviewOpen]], 'Diffview Open', { nowait = true })
    nmap('<leader>gh', [[:DiffviewFileHistory]], 'Diffview File History', { nowait = true })
    nmap('<leader>gx', [[:DiffviewClose<CR>]], 'Diffview Close')
end

local M = {
    {
        'sindrets/diffview.nvim',
        config = config,
    },
}

return M
