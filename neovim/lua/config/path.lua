local plat = require('util.plat')
local path = require('util.path')

local M = {
    home = os.getenv('HOME'), -- Home path

    nvim_config = vim.fn.stdpath('log'), -- Neovim config path
    nvim_data = vim.fn.stdpath('data'), -- Neovim data path
    nvim_log = vim.fn.stdpath('log'), -- Neovim log path

    lazy = path.lazy, -- Lazy plugin path

    python = path.python_path, -- Python path
}

--Add python path
if plat.is_windows then
    M.python_path = path.os_path(M.home .. '/scoop/apps/python/current/python')
else
    M.python_path = '/usr/bin/python3'
end

--- Add lazy plugin path.
M.lazy = path.os_path(M.nvim_data .. '/lazy')

return M
