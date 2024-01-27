local config = function()
    local ok, plugin = pcall(require, 'diffview')

    if not ok then
        return
    end

    plugin.setup()

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
