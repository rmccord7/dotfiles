local config = function()
    local ok, plugin = pcall(require, 'diffview')

    if not ok then
        return
    end

    plugin.setup()

    nmap('<leader>do', [[:DiffviewOpen]], 'Diffview Open', { nowait = true })
    nmap('<leader>dh', [[:DiffviewFileHistory]], 'Diffview File History', { nowait = true })
    nmap('<leader>dc', [[:DiffviewClose<CR>]], 'Diffview Close')
end

local M = {
    {
        'sindrets/diffview.nvim',
        config = config,
    },
}

return M
