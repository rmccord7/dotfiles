local M = {
    os_name = vim.loop.os_uname().sysname,
    is_mac = vim.loop.os_uname().sysname == 'Darwin',
    is_linux = vim.loop.os_uname().sysname == 'Linux',
    is_windows = vim.loop.os_uname().sysname == 'Windows_NT',
    os_open_cmd = '',
}

-- Set OS open command
if M.is_linux then
    M.os_open_cmd = 'xdg-open'
else
    if M.is_windows then
        M.os_open_cmd = 'explorer'
    else
        if M.is_mac then
            M.os_open_cmd = 'open'
        end
    end
end

return M
