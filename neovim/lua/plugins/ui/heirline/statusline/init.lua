M = {}

local global = require('global')

local utils = require('heirline.utils')
local conditions = require('heirline.conditions')

local colors = require('material.colors')

local mode = require('plugins.ui.heirline.statusline.mode')
local file = require('plugins.ui.heirline.statusline.file')
local git = require('plugins.ui.heirline.statusline.git')
local lsp = require('plugins.ui.heirline.statusline.lsp')

-- Filetypes where certain elements of the statusline will not be shown
local filetypes = {
    '^git.*',
    'fugitive',
    '^toggleterm$',
}

-- Buftypes which should cause elements to be hidden
local buftypes = {
    'nofile',
    'prompt',
    'help',
    'quickfix',
}

-- Filetypes which force the statusline to be inactive
local force_inactive_filetypes = {
    '^lazy$',
    '^netrw$',
    '^TelescopePrompt$',
    '^NvimTree$',
}

local Align = { provider = '%=' }
local Space = { provider = ' ' }

-- We're getting minimalists here!
local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = '%7(%l/%3L%):%2c %P',
    hl = {
        fg = colors.main.green,
        bg = utils.get_highlight('StatusLine').bg,
    },
}

-- local ScrollBar = {
--     static = {
--         sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
--     },
--     provider = function(self)
--         local curr_line = vim.api.nvim_win_get_cursor(0)[1]
--         local lines = vim.api.nvim_buf_line_count(0)
--         local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
--         return string.rep(self.sbar[i], 2)
--     end,
--     hl = { fg = colors.blue, bg = colors.editor.bg },
-- }

local Lazy = {
    condition = function(self)
        return not conditions.buffer_matches({
            filetype = self.filetypes,
        }) and require('lazy.status').has_updates()
    end,
    update = { 'User', pattern = 'LazyUpdate' },
    provider = function()
        return '  ' .. require('lazy.status').updates() .. ' '
    end,
    on_click = {
        callback = function()
            require('lazy').update()
        end,
        name = 'update_plugins',
    },
    hl = {
        fg = colors.main.green,
        bg = utils.get_highlight('StatusLine').bg,
    },
}

local Treesitter = {
    provider = 'TS',
    condition = function(self)
        local buf = vim.api.nvim_get_current_buf()
        local highlighter = require "vim.treesitter.highlighter"
        if highlighter.active[buf] then
            return true
        else
            return false
        end
    end,
    hl = {
        fg = colors.main.green,
        bg = utils.get_highlight('StatusLine').bg,
    },
}

local sep = '  '
local cwd = {
    init = function(self)
        self.cwd = vim.fn.getcwd(0)
        self.cwd = string.gsub(self.cwd, global.home_path, '~')
        self.cwd = string.gsub(self.cwd, '\\', '/')
    end,
    hl = {
        fg = utils.get_highlight('Directory').fg,
        bg = utils.get_highlight('StatusLine').bg,
        italic = true,
    },
    flexible = 1,
    {
        -- evaluates to the full-length path
        provider = function(self)
            local trail = self.cwd:sub(-1) == '/' and '' or '/'
            return '  ' .. table.concat(vim.fn.split(self.cwd .. trail, '/'), sep) .. sep
        end,
    },
    {
        -- evaluates to the shortened path
        provider = function(self)
            local cwd = vim.fn.pathshorten(self.cwd)
            return '  ' .. table.concat(vim.fn.split(cwd, '/'), sep) .. sep
        end,
    },
    {
        -- evaluates to "", hiding the component
        provider = '',
    },
}

M = {
    static = {
        filetypes = filetypes,
        buftypes = buftypes,
        force_inactive_filetypes = force_inactive_filetypes,
    },

    condition = function(self)
        return not conditions.buffer_matches({
            filetype = self.force_inactive_filetypes,
        })
    end,

    mode.Mode,
    Space,
    cwd,
    Space,
    git.Git,
    Align,

    file.FileType,
    Space,
    file.FileNameBlock,
    Space,
    lsp.Diagnostics,
    Space,
    Ruler,
    Space,
    file.FileSize,
    Space,
    file.FileEncoding,
    Space,
    file.FileFormat,
    Align,

    Treesitter,
    Space,
    Lazy,
    Space,
    lsp.LSPActive,
    Align,
}

return M
