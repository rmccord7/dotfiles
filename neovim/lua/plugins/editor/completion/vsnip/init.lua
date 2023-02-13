local config = function()
    local global = require('global')

    vim.g.vsnip_extra_mapping = true
    vim.g.vsnip_snippet_dir = global.home_path .. os_path('/dotfiles/neovim/lua/plugins/editor/completion/vsnip/snippets')
end

local M = {
    {
        'hrsh7th/vim-vsnip',
        config = config,
        event = 'InsertEnter',
    },

}

return M
