-- local telescope_ok, _ = pcall(require, 'telescope')
--
-- local util = require('rm.plugins.telescope.util')

local defaults = {}

local M = {}

function M.setup(options)
    M.options = vim.tbl_deep_extend('force', {}, defaults, options or {})

    vim.notify('Project Config Loaded')
end

return M
