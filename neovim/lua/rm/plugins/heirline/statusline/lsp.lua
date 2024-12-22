local M = {}

local utils = require('heirline.utils')
local conditions = require('heirline.conditions')

local colors = require('material.colors')

M.LSPActive = {
    condition = conditions.lsp_attached,
    update = { 'LspAttach', 'LspDetach' },

    -- You can keep it simple,
    -- provider = " [LSP]",

    -- Or complicate things a bit and get the servers names
    provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return ' [' .. table.concat(names, ' ') .. ']'
    end,
    hl = {
        fg = colors.main.green,
        bg = utils.get_highlight('StatusLine').bg,
        bold = true,
    },
}

M.Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
        error_icon = '  ',
        warn_icon = '  ',
        info_icon = '  ',
        hint_icon = '  ',
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { 'DiagnosticChanged', 'BufEnter' },

    {
        provider = '![',
    },
    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
        end,
        hl = { fg = colors.lsp.error },
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
        end,
        hl = { fg = colors.lsp.warning },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. ' ')
        end,
        hl = { fg = colors.lsp.info },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = colors.lsp.hint },
    },
    {
        provider = ']',
    },
}

return M
