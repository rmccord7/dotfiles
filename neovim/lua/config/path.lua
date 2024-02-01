local plat = require('util.plat')
local path_util = require('util.path')

local M = {
    home = os.getenv('HOME'),                                                     -- Home path

    nvim_config = vim.fn.stdpath('config'),                                       -- Neovim config path
    nvim_data = vim.fn.stdpath('data'),                                           -- Neovim data path
    nvim_log = vim.fn.stdpath('log'),                                             -- Neovim log path

    plugins = path_util.os_path(vim.fn.stdpath('data') .. '/lazy'),               -- Plugin path
    dev_plugins = path_util.os_path(vim.fn.stdpath('data') .. '/dev'),            -- Dev plugin path

    lazy_plugin = path_util.os_path(vim.fn.stdpath('data') .. '/lazy/lazy.nvim'), -- Lazy plugin path

    lsp_log = path_util.os_path(vim.fn.stdpath('log') .. '/lsp'),                 -- Lazy plugin path

    python = function()
        if plat.is_windows then
            M.python_path = path_util.os_path(M.home .. '/scoop/apps/python/current/python.exe')
        else
            M.python_path = '/usr/bin/python3'
        end
    end, -- Python path
}

return M
