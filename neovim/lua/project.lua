local telescope_ok, _ = pcall(require, 'telescope')
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')

local util = require('plugins.editor.navigation.telescope.util')

local defaults = {
    file_ignore_patterns = {},
}

local M = {}

function M.setup(config)
    M.config = vim.tbl_deep_extend('force', {}, defaults, config or {})

    if telescope_ok then
        util.custom('<leader>ff', 'find_files', 'Find Project Files', {
            file_ignore_patterns = M.config.file_ignore_patterns,
        })
    end

    --TODO: Test for clangd
    if lspconfig_ok then

        lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
            if config.name == 'clangd' then
                config.cmd = { 'clangd_test' }
            end
        end)
    end

    vim.notify('Project Config Loaded')
end

return M
