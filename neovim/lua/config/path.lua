local plat = require('util.plat')
local path = require('util.path')

local M = {
    home = os.getenv('HOME'), -- Home path

    nvim_config = vim.fn.stdpath('log'), -- Neovim config path
    nvim_data = vim.fn.stdpath('data'), -- Neovim data path
    nvim_log = vim.fn.stdpath('log'), -- Neovim log path

    plugins = path.os_path(vim.fn.stdpath('data') .. '/lazy'), -- Plugin path
    lazy_plugin = path.os_path(vim.fn.stdpath('data') .. '/lazy/lazy.nvim'), -- Lazy plugin path

    python = function()
        if plat.is_windows then
            M.python_path = path.os_path(M.home .. '/scoop/apps/python/current/python')
        else
            M.python_path = '/usr/bin/python3'
        end
    end, -- Python path
}

return M
