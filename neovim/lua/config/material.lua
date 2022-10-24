local ok, material = pcall(require, "material")

if not ok then
    return
end

local colors = require('material.colors')

-- Set theme
vim.g.material_style = 'deep ocean'

material.setup({
  plugins = {
    --'indent-blankline',
    --'lsp-saga',
    --'nvim-cmp',
    --'nvim-tree',
    --'telescope',
    --'trouble',
    --'which-key',
  },
  custom_colors = {
    fg           = '#717CB4',
    comments     = '#5A6077',
    line_numbers = '#5A6077',
  },
  custom_highlights = {
    -- Command mode
    MsgArea = { fg = '#E2795B', bold = true},

    -- Lightspeed
    LightspeedLabel                  = { fg = colors.darkgreen, bold = true, underline = true },
    --LightspeedLabelOverlapped        = { fg = colors.darkred, bold = true, underline = true },
    LightspeedLabelDistant           = { fg = colors.darkpurple, bold = true, underline = true },
    --LightspeedLabelDistantOverlapped = { fg = colors.darkpurple, bold = true, underline = true },
    LightspeedShortcut               = { fg = colors.blue, bold = true, underline = true },
    --LightspeedShortcutOverlapped     = { fg = colors.blue, bold = true, underline = true },
    LightspeedMaskedChar             = { fg = colors.darkpurple, bold = true },
    LightspeedGreyWash               = { fg = colors.comments },
    LightspeedUnlabeledMatch         = { fg = '#E2795B', bold = true },
    LightspeedUniqueChar             = { fg = '#E2795B', bold = true },
  }
})

vim.cmd 'colorscheme material'
