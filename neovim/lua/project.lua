local telescope_ok, _ = pcall(require, 'telescope')
if not telescope_ok then
    return
end

local util = require('config.telescope.util')

local defaults = {
    file_ignore_patterns = {},
}

local M = {}

function M.setup(settings)
    M.settings = vim.tbl_deep_extend('force', {}, defaults, settings or {})

    if telescope_ok then

        util.custom('<leader>ff', 'find_files', 'Find Project Files', {
            file_ignore_patterns = M.settings.file_ignore_patterns,
        })
    end

    vim.notify('Project Config Loaded')
end

return M
