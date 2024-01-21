local os_uname = vim.uv.os_uname()

local M = {
    -- Platform arch
    arch = os_uname.machine,

    -- Platform OS
    os = {
        name = os_uname.sysname,
        version = os_uname.release,
    },

    -- Platform binaries
    bin = {
        rg = false, -- Rip grep support
    },
}


-- Quickly determine platform
M.is_mac = M.os.name == 'Darwin'
M.is_linux = M.os.name == 'Linux'
M.is_windows = M.os.name == 'Windows_NT'

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

-- If platform supports rip grep.
if vim.fn.executable('rg') == 1 then
    M.bin.rg = true
end

--dump(M)

return M
