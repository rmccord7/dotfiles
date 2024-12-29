return {
  'marko-cerovac/material.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    plugins = {
      'indent-blankline',
      'gitsigns',
      'nvim-cmp',
      'telescope',
      'trouble',
      'which-key',
    },
    custom_colors = function(c)
      c.editor.fg = '#717CB4'
      c.syntax.variable = '#717CB4'
      c.syntax.comments = '#5A6077'
      c.editor.line_numbers = '#5A6077'
    end,
  },
  config = function(_, opts)
    local colors = require('material.colors')

    opts.custom_highlights = {
      -- Command mode
      MsgArea = { fg = '#E2795B', bold = true },

      -- Treesitter
      ['@type.qualifier'] = { fg = colors.main.orange },

      ['@keyword'] = { fg = colors.main.orange },

      ['@macro'] = { fg = colors.main.orange },
      ['@preproc'] = { fg = colors.main.orange },

      ['@constant.macro'] = { fg = colors.main.orange },

      -- CmpItemKindSnippet = { fg = colors.editor.fg, bg = colors.main.orange },
      -- CmpItemKindKeyword = { fg = colors.editor.fg, bg = colors.main.red },
      -- CmpItemKindText = { fg = colors.editor.fg, bg = colors.main.teal },
      -- CmpItemKindMethod = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindConstructor = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindFunction = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindFolder = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindModule = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindConstant = { fg = colors.editor.fg, bg = colors.main.orange },
      -- CmpItemKindField = { fg = colors.editor.fg, bg = colors.main.green },
      -- CmpItemKindProperty = { fg = colors.editor.fg, bg = colors.main.green },
      -- CmpItemKindEnum = { fg = colors.editor.fg, bg = colors.main.green },
      -- CmpItemKindUnit = { fg = colors.editor.fg, bg = colors.main.green },
      -- CmpItemKindClass = { fg = colors.editor.fg, bg = colors.main.yellow },
      -- CmpItemKindVariable = { fg = colors.editor.fg, bg = colors.main.orange },
      -- CmpItemKindFile = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindInterface = { fg = colors.editor.fg, bg = colors.main.yellow },
      -- CmpItemKindColor = { fg = colors.editor.fg, bg = colors.main.red },
      -- CmpItemKindReference = { fg = colors.editor.fg, bg = colors.main.red },
      -- CmpItemKindEnumMember = { fg = colors.editor.fg, bg = colors.main.red },
      -- CmpItemKindStruct = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindValue = { fg = colors.editor.fg, bg = colors.main.orange },
      -- CmpItemKindEvent = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindOperator = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindTypeParameter = { fg = colors.editor.fg, bg = colors.main.blue },
      -- CmpItemKindCopilot = { fg = colors.editor.fg, bg = colors.main.teal },

      -- IblScope = {fg = colors.editor.border },
      -- IblWhitespace = {fg = colors.editor.disabled },
      -- IblIndex = {fg = colors.editor.disabled },
    }

    require('material').setup(opts)

    vim.cmd('colorscheme material')
  end,
  init = function(_)
    vim.g.material_style = 'deep ocean'
  end,
}
