local material = require('material.colors')

-- Set theme
vim.g.material_style = 'deep ocean'

require('material').setup({
  custom_colors = {
    fg          = '#717CB4',
    comments    = '#5A6077',
    line_number = '#5A6077',
  },
  custom_highlights = {
    -- Command mode
    MsgArea = { fg = material.darkorange, style = 'bold'},

		-- Lightspeed
    LightspeedLabel                  = { fg = material.darkgreen, style = 'bold,underline' },
		LightspeedLabelOverlapped        = { fg = material.darkred, style = 'bold,underline' },
		LightspeedLabelDistant           = { fg = material.darkpurple, style = 'bold,underline' },
		LightspeedLabelDistantOverlapped = { fg = material.darkpurple, style = 'bold,underline' },
		LightspeedShortcut               = { fg = material.blue, style = 'bold,underline' },
		LightspeedShortcutOverlapped     = { fg = material.blue, style = 'bold,underline' },
		LightspeedMaskedChar             = { fg = material.darkpurple, style = 'bold' },
    LightspeedGreyWash               = { fg = material.comments },
		LightspeedUnlabeledMatch         = { fg = material.darkorange, style = 'bold' },
		LightspeedUniqueChar             = { fg = material.darkorange, style = 'bold' },
  }
})

vim.cmd[[colorscheme material]]
