local M = {
    enable = true, -- Enable external apps
    rg = false, -- Rip grep support
}

-- Make sure external apps are enabled.
if M.enable then

    -- If platform supports rip grep.
    if vim.fn.executable('rg') == 1 then
        M.rg = true
    end

end

return M
