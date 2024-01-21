require('global')

local config = require('config')

require('settings')
require('mappings')
require('autocommands')

-- Install lazy plugin manager if it doesn't exist.
local lazy_path = config.path.lazy .. '/lazy.nvim'

if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazy_path,
    })
end

-- Add lazy to the runtime.
vim.opt.rtp:prepend(lazy_path)

local config = {
    checker = {
        enabled = true,
    },
}

-- Load lazy plugins.
require('lazy').setup('plugins', config)

-- Load project config if it exists.
require('project')
