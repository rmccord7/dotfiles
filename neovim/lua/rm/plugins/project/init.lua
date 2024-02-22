local config = function()
    local ok, plugin = pcall(require, 'project_nvim')

    if not ok then
        return
    end

    plugin.setup({
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
