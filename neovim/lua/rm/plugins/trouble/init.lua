local config = function()

    local ok, plugin = pcall(require, 'trouble')

    if not ok then
        return
    end

    plugin.setup()

    -- nmap('<leader>xx', ':Trouble<CR>', 'Trouble toggle')
    -- nmap('<leader>xw', ':Trouble workspace_diagnostics<CR>', 'Trouble workspace diagnostics')
    -- nmap('<leader>xd', ':Trouble document_diagnostics<CR>', 'Trouble document diagnostics')
    -- nmap('<leader>xq', ':Trouble quickfix<CR>', 'Trouble quickfix')
    -- nmap('<leader>xl', ':Trouble loclist<CR>', 'Trouble loclist')
    -- nmap('<leader>xr', ':Trouble lsp_references<CR>', 'Trouble LSP Ref')
    -- nmap('<leader>xn', [[:lua require('trouble').next({skip_groups = false, jump = true})<CR>]], 'Trouble Next')
    -- nmap('<leader>xp', [[:lua require('trouble').previous({skip_groups = false, jump = true})<CR>]], 'Trouble Previous')
end

local M = {
    {
        'folke/trouble.nvim',
        config = config,
        dependencies = {
            'kyazdani42/nvim-web-devicons',
            'nvim-telescope/telescope.nvim',
        }
    },
}

return M

