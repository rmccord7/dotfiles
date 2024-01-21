local config = function()
    require('reach').setup({})

    nmap('<leader>b', ':ReachOpen buffers<CR>', 'Reach Open Buffers')
    nmap("<leader>'", ':ReachOpen marks<CR>', 'Reach Open Marks')
end

local M = {
    {
        'toppair/reach.nvim',
        config = config,
    },
}

return M
