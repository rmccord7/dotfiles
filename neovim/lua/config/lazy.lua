require('global')

path = require('config.path')

local M = {
    enabled = true, -- Lazy plugin manager enabled
    config = { -- Lazy config
        checker = { -- Update checker
            enabled = true, -- Enable check for updates at startup
        },
    },
}

--- Starts lazy plugin manager.
function M.start()

    if M.enabled then

        -- Clone lazy plugin if it does not exist.
        if not vim.uv.fs_stat(path.lazy_plugin) then
            vim.fn.system({
                'git',
                'clone',
                '--filter=blob:none',
                'https://github.com/folke/lazy.nvim.git',
                '--branch=stable',
                path.lazy_plugin,
            })
        end

        -- Add lazy to the runtime.
        vim.opt.rtp:prepend(path.lazy_plugin)

        require('lazy').setup('plugins', M.config)

        nmap('<leader>lh', [[:Lazy home<CR>]], 'Lazy home')
    end
end

return M
