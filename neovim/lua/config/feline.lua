require'nvim-web-devicons'.setup {}

local colors = require('material.colors')

local ok, feline = pcall(require, "feline")

if not ok then
    return
end

local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local components = {
  active = {{}, {}, {}},
  inactive = {{}, {}, {}},
}

local vi_mode_colors = {
  NORMAL = colors.blue,
  INSERT = colors.green,
  VISUAL = colors.purple,
  LINES = colors.violet,
  OP = colors.green,
  BLOCK = colors.blue,
  REPLACE = colors.red,
  ['V-REPLACE'] = colors.violet,
  ENTER = colors.cyan,
  MORE = colors.cyan,
  SELECT = colors.orange,
  COMMAND = colors.yellow,
  SHELL = colors.green,
  TERM = colors.green,
  NONE = colors.yellow
}

local vi_mode_text = {
  NORMAL = 'NORMAL',
  OP = 'OP',
  INSERT = 'INSERT',
  VISUAL = 'VISUAL',
  LINES = 'V-LINE',
  BLOCK = 'V-BLOCK',
  REPLACE = 'REPLACE',
  ['V-REPLACE'] = 'V-REPLACE',
  ENTER = 'ENTER',
  MORE = 'MORE',
  SELECT = 'SELECT',
  COMMAND = 'COMMAND',
  SHELL = 'SHELL',
  TERM = 'TERM',
  NONE = 'NONE'
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = ' '
    elseif os == 'MAC' then
        icon = ' '
    else
        icon = ' '
    end
    return icon .. os
end

-- VI mode
components.active[1][1] = {
  provider = function()
      local current_text = ' ' .. vi_mode_text[vi_mode_utils.get_vim_mode()] .. ' '
      return current_text
  end,
  hl = function()
      local val = {
          name = vi_mode_utils.get_mode_highlight_name(),
          fg = colors.bg,
          bg = vi_mode_utils.get_mode_color(),
          style = 'bold'
      }
      return val
  end,
  right_sep = {'right_rounded', ' '}
}

--File Info
components.active[1][2] = {
  provider = 'file_info',
  hl = {
      fg = colors.bg,
      bg = colors.darkgreen,
      style = 'bold'
  },
  left_sep = {
      ' ', 'slant_left_2',
      {str = ' ', hl = {bg = colors.darkgreen, fg = 'NONE'}}
  },
  right_sep = {'right_rounded', ' '},
  icon = ''
}

-- gitBranch
components.active[1][3] = {
  provider = 'git_branch',
  hl = {
    fg = colors.blue,
    bg = 'bg',
    style = 'bold'
  },
}

-- diffAdd
components.active[1][4] = {
  provider = 'git_diff_added',
  hl = {
    fg = colors.darkgreen,
    bg = 'bg',
    style = 'bold'
  }
}

-- diffModfified
components.active[1][5] = {
  provider = 'git_diff_changed',
  hl = {
    fg = 'orange',
    bg = 'bg',
    style = 'bold'
  }
}

-- diffRemove
components.active[1][6] = {
  provider = 'git_diff_removed',
  hl = {
    fg = 'red',
    bg = 'bg',
    style = 'bold'
  }
}

-- LspName
components.active[2][1] = {
  provider = 'lsp_client_names',
  hl = {
    fg = colors.blue,
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}

-- diagnosticErrors
components.active[2][2] = {
  provider = 'diagnostic_errors',
  enabled = function() return lsp.diagnostics_exist('ERROR') end,
  hl = {
    fg = 'red',
    style = 'bold'
  }
}

-- diagnosticWarn
components.active[2][3] = {
  provider = 'diagnostic_warnings',
  enabled = function() return lsp.diagnostics_exist('WARN') end,
  hl = {
    fg = 'yellow',
    style = 'bold'
  }
}

-- diagnosticHint
components.active[2][4] = {
  provider = 'diagnostic_hints',
  enabled = function() return lsp.diagnostics_exist('HINT') end,
  hl = {
    fg = 'cyan',
    style = 'bold'
  }
}
-- diagnosticInfo
components.active[2][5] = {
  provider = 'diagnostic_info',
  enabled = function() return lsp.diagnostics_exist('INFO') end,
  hl = {
    fg = 'skyblue',
    style = 'bold'
  }
}

-- fileIcon
components.active[3][1] = {
  provider = function()
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon == nil then
      icon = ''
    end
    return icon
  end,
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
}

-- fileType
components.active[3][2] = {
  provider = 'file_type',
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
}

-- fileSize
components.active[3][3] = {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
  hl = {
    fg = colors.darkgreen,
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}

-- fileFormat
components.active[3][4] = {
  provider = file_osinfo,
  hl = {
    fg = colors.blue,
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}

-- fileEncode
components.active[3][5] = {
  provider = 'file_encoding',
  hl = {
    fg = colors.blue,
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}

-- lineInfo
components.active[3][6] = {
  provider = 'position',
  hl = {
    fg = colors.darkgreen,
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}

-- linePercent
components.active[3][7] = {
  provider = 'line_percentage',
  hl = {
    fg = colors.darkgreen,
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}

-- scrollBar
components.active[3][8] = {
  provider = 'scroll_bar',
  hl = {
    fg = colors.darkgreen,
    bg = 'bg',
  },
}

feline.setup({
  default_bg = colors.bg,
  default_fg = colors.fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
})

-- Winbar
components = {
  active = {{}, {}},
  inactive = {{}, {}},
}

components.active[2][1] = {
  provider = {
    name = 'file_info',
    opts = {
      type = 'unique'
    },
  },
  hl = {
    fg = 'skyblue',
    bg = 'NONE',
    style = 'bold',
  },
  icon = ''
}

components.inactive[2][1] = {
  provider = {
    name = 'file_info',
    opts = {
      type = 'unique'
    },
  },
  hl = {
    fg = colors.orange,
    bg = 'NONE',
    style = 'bold',
  },
  icon = ''
}

-- Setup feline.nvim winbar
require('feline').winbar.setup {
    components = components
}
