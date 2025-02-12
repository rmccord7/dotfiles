local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local colors = require('material.colors')

local M = {}

M.Git = {
  condition = conditions.is_git_repo,

  init = function(self)
    ---@diagnostic disable-next-line: undefined-field
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,

  hl = {
    fg = colors.main.orange,
    bg = utils.get_highlight('StatusLine').bg,
  },

  { -- git branch name
    provider = function(self)
      return ' ' .. self.status_dict.head
    end,
    hl = { bold = true },
  },
  -- You could handle delimiters, icons and counts similar to Diagnostics
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = '(',
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ('+' .. count)
    end,
    hl = { fg = colors.git.added },
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and ('-' .. count)
    end,
    hl = { fg = colors.git.removed },
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and ('~' .. count)
    end,
    hl = { fg = colors.git.modified },
  },
  {
    condition = function(self)
      return self.has_changes
    end,
    provider = ')',
  },
}

return M
