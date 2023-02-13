local telescope_ok, _ = pcall(require, 'telescope')
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')

local util = require('plugins.editor.navigation.telescope.util')

local defaults = {}

local M = {}

function M.setup(options)
    M.options = vim.tbl_deep_extend('force', {}, defaults, options or {})

    -- Replace clangd LSP command
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
