local config = function()
    local ok, plugin = pcall(require, 'reach')

    if not ok then
        return
    end

    plugin.setup({})

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
