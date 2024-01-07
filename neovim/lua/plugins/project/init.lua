local config = function()
    require('project_nvim').setup({
        patterns = {
            '.git',
            '.nvimrc.lua',
            '.nvimrc',
            '.p4config',
            '.p4.conf',
            'compile_commands.json',
        },
    })
end

local M = {
    {
        'ahmedkhalf/project.nvim',
        config = config,
    },
}

return M
