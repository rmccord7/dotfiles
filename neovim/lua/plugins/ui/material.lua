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
