local plat = require('util.plat')

--- Path locals.
local M = {}

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

return M
