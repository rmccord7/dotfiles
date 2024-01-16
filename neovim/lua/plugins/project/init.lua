local config = function()
    require('project_nvim').setup({
        patterns = {
            '.nvim.lua',
            'compile_commands.json',
            '.p4config',
            '.git',
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
