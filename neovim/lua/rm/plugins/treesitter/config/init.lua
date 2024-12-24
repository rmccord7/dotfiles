local KB_SIZE = 1024

-- Defaults
local default = {
  size = 75 * KB_SIZE,
  lc = 75000,
}

local mt = {
  __index = function()
    return default
  end,
}

--- TS config
local M = {}

-- TS language config
M.ft = {}

setmetatable(M.ft, mt)

return M
