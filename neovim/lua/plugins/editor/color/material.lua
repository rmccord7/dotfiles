local config = function()

    local ok, material = pcall(require, 'material')

    if not ok then
        return
    end

    local colors = require('material.colors')

    -- Set theme
    vim.g.material_style = 'deep ocean'

    material.setup({
        plugins = {
            'indent-blankline',
            'lspsaga',
            'gitsigns',
            'nvim-cmp',
            'nvim-tree',
            'telescope',
            'trouble',
            'which-key',
        },
        custom_colors = function(colors)
            colors.editor.fg = '#717CB4'
            colors.syntax.comments = '#5A6077'
            colors.editor.line_numbers = '#5A6077'
        end,
        custom_highlights = {
            -- Command mode
            MsgArea = { fg = '#E2795B', bold = true },

            -- Treesitter
            ['@macro'] = { fg = colors.main.orange },

            --TODO: Remove lightspeed

            -- Lightspeed
            LightspeedLabel = { fg = colors.main.darkgreen, bold = true, underline = true },
            --LightspeedLabelOverlapped        = { fg = colors.main.darkred, bold = true, underline = true },
            LightspeedLabelDistant = { fg = colors.main.darkpurple, bold = true, underline = true },
            --LightspeedLabelDistantOverlapped = { fg = colors.main.darkpurple, bold = true, underline = true },
            LightspeedShortcut = { fg = colors.main.blue, bold = true, underline = true },
            --LightspeedShortcutOverlapped     = { fg = colors.main.blue, bold = true, underline = true },
            LightspeedMaskedChar = { fg = colors.main.darkpurple, bold = true },
            LightspeedGreyWash = { fg = colors.syntax.comments },
            LightspeedUnlabeledMatch = { fg = '#E2795B', bold = true },
            LightspeedUniqueChar = { fg = '#E2795B', bold = true },

            CmpItemKindSnippet = { fg = colors.editor.fg, bg = colors.main.orange },
            CmpItemKindKeyword = { fg = colors.editor.fg, bg = colors.main.red },
            CmpItemKindText = { fg = colors.editor.fg, bg = colors.main.teal },
            CmpItemKindMethod = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindConstructor = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindFunction = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindFolder = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindModule = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindConstant = { fg = colors.editor.fg, bg = colors.main.orange },
            CmpItemKindField = { fg = colors.editor.fg, bg = colors.main.green },
            CmpItemKindProperty = { fg = colors.editor.fg, bg = colors.main.green },
            CmpItemKindEnum = { fg = colors.editor.fg, bg = colors.main.green },
            CmpItemKindUnit = { fg = colors.editor.fg, bg = colors.main.green },
            CmpItemKindClass = { fg = colors.editor.fg, bg = colors.main.yellow },
            CmpItemKindVariable = { fg = colors.editor.fg, bg = colors.main.orange },
            CmpItemKindFile = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindInterface = { fg = colors.editor.fg, bg = colors.main.yellow },
            CmpItemKindColor = { fg = colors.editor.fg, bg = colors.main.red },
            CmpItemKindReference = { fg = colors.editor.fg, bg = colors.main.red },
            CmpItemKindEnumMember = { fg = colors.editor.fg, bg = colors.main.red },
            CmpItemKindStruct = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindValue = { fg = colors.editor.fg, bg = colors.main.orange },
            CmpItemKindEvent = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindOperator = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindTypeParameter = { fg = colors.editor.fg, bg = colors.main.blue },
            CmpItemKindCopilot = { fg = colors.editor.fg, bg = colors.main.teal },
        },
    })

    vim.cmd('colorscheme material')
end

local M = {
    {
        'marko-cerovac/material.nvim',
        lazy = false,
        config = config,
        priority = 1000,
    },
}

return M
