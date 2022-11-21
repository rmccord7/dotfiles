M = {}

local IGNORE_HIGHLIGHT_CHECK = 0

local KB_SIZE                    = 1024
local DEFAULT_MAX_BUF_SIZE_KB    = 75 * KB_SIZE
local DEFAULT_MAX_BUF_LINE_COUNT = 75000

local Highlight_Lang_CFG = {

  -- Use default if file language not configured
  __index = function ()
            return
            {
              size       = IGNORE_HIGHLIGHT_CHECK,
              line_count = IGNORE_HIGHLIGHT_CHECK
            }
            end
}

-- C language file extension config
local DEFAULT_C_MAX_BUF_SIZE_KB    = DEFAULT_MAX_BUF_SIZE_KB
local DEFAULT_C_MAX_BUF_LINE_COUNT = DEFAULT_MAX_BUF_LINE_COUNT

Highlight_Lang_CFG.c = {

  c = {
    size       = IGNORE_HIGHLIGHT_CHECK,
    line_count = IGNORE_HIGHLIGHT_CHECK,
  },

  h = {
    size       = 75 * KB_SIZE,
    line_count = 12000
  },

  -- Use default if file extension not specified
  __index = function ()
            return
            {
              size       = DEFAULT_C_MAX_BUF_SIZE_KB,
              line_count = DEFAULT_C_MAX_BUF_LINE_COUNT
            }
            end
}

function GetBufFileExtension(bufnr)

  -- Telescope buffer preview will have a name of nil unless buffer
  -- has been opened previously

  local file_extension = vim.api.nvim_buf_get_name(bufnr):match("^.+(%..+)$")

  if file_extension then
    file_extension = string.sub(file_extension, 2)
  end

  return file_extension
end

function M.DisableHighlight(lang, bufnr)

  local buf_size = 0
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  if ok and stats then
      buf_size = stats.size
  end

  local buf_line_count = vim.api.nvim_buf_line_count(bufnr)

  local lang_cfg = Highlight_Lang_CFG[lang]

  -- If we don't have a config for the specified language, then
  -- highlighting will be enabled.
  if lang_cfg then

    -- Possible nil is returned by telescope previewer for
    -- buf name.
    local file_extension = GetBufFileExtension(bufnr)

    if file_extension then

      -- If we have a configuration for this
      -- languages file extension.
      local ext_cfg = lang_cfg[file_extension]

      -- Check if we should disable highlighting
      if (ext_cfg.size ~= IGNORE_HIGHLIGHT_CHECK) and (buf_size > ext_cfg.size) then
         return true
      end

      if (ext_cfg.line_count ~= IGNORE_HIGHLIGHT_CHECK) and (buf_line_count > ext_cfg.line_count) then
         return true
      end

    end
  end

  return false
end

return M
