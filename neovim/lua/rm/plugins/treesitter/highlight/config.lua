local config = require('rm.plugins.treesitter.config')

--- Helper function to get buffer file extension
local function GetBufFileExtension(bufnr)
  -- Telescope buffer preview will have a name of nil unless buffer
  -- has been opened previously

  local ext = vim.api.nvim_buf_get_name(bufnr):match('^.+(%..+)$')

  if ext then
    ext = string.sub(ext, 2)
  end

  return ext
end

--- Disables TS highlighting for the current buffer if buffer size or
--- buffer line count exceeds the configured maximums for the specified
--- language.
local function Disable(_, bufnr)
  local buf = {
    ext = '',
    size = 0,
    lc = 0,
  }

  -- Get buffer file extension
  buf.ext = GetBufFileExtension(bufnr)

  -- Get buffer size
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if ok and stats then
    buf.size = stats.size
  end

  -- Get buffer line count
  buf.lc = vim.api.nvim_buf_line_count(bufnr)

  -- Disable highlighting based on TS config
  local check = config.ft[buf.ext]

  -- Disable highlighting if buffer size is too big
  if buf.size > check.size then
    return true
  end

  -- Disable highlighting if buffer line count is too big
  if buf.lc > check.lc then
    return true
  end

  return false
end

return {
  enable = true,
  disable = Disable,
}
