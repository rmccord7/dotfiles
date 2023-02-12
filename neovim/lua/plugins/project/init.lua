local M = {

    {
        'ahmedkhalf/project.nvim',
        config = function()
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
        end,
    },

    {
        'editorconfig/editorconfig-vim',
    },

    {
        'rmccord7/ss1pwn',
        ft = {'c'},
    },

    {
        'ckipp01/stylua-nvim',
    },
}

return M
