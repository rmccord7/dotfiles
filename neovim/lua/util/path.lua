local plat = require('util.plat')

--- Path locals.
local M = {
    home = os.getenv('HOME'), -- Home path
    nvim_config = vim.fn.stdpath('log'), -- Neovim config path
    nvim_data = vim.fn.stdpath('data'), -- Neovim data path
    nvim_log = vim.fn.stdpath('log'), -- Neovim log path
}

--- Takes a sanitized path and converts it to the os
--- specific path.
--- @param path string File system path.
function M.os_path(path)
    if plat.is_windows then
        path = path:sub(1, 1):upper() .. path:sub(2)
        path = path:gsub(path, '/', '\\')
    end
    return path
end

--- Returns a path in linux/mac-os format.
--- @param path string File system path.
function M.sanitize(path)
    if plat.is_windows then
        path = path:sub(1, 1):upper() .. path:sub(2)
        path = path:gsub(path, '\\', '/')
    end
    return path
end

--Add python path
if plat.is_windows then
    M.python = M.os_path(M.home .. '/scoop/apps/python/current/python')
else
    M.python = '/usr/bin/python3'
end

--- Add lazy plugin path.
M.lazy = M.os_path(M.nvim_data .. '/lazy')

return M
